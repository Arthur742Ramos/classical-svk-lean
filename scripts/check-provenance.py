"""Reconcile structured provenance, immutable pins, and vendored source hashes."""

from pathlib import Path
import hashlib
import json
import re
from concurrent.futures import ThreadPoolExecutor
from urllib.request import Request, urlopen

import yaml


ROOT = Path(__file__).resolve().parents[1]
DIRECTED_REPO = "https://github.com/Dominique-Lawson/Directed-Topology-Lean-4"
DIRECTED_SHA = "009529606c66d37ef93b4b81b8587f71ce4d2c56"
MATHLIB_REPO = "https://github.com/leanprover-community/mathlib4.git"
MATHLIB_SHA = "8f9d9cff6bd728b17a24e163c9402775d9e6a365"
COMPUTATIONAL_PATHS_SHA = "257c659b7973aeda900d86a5da73b208712c7523"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes().replace(b"\r\n", b"\n")).hexdigest()


def upstream_sha256(item: dict[str, str], commit: str) -> str:
    path = item["source_path"]
    url = f"{DIRECTED_REPO.replace('https://github.com/', 'https://raw.githubusercontent.com/')}/{commit}/{path}"
    request = Request(url, headers={"User-Agent": "classical-svk-provenance-check"})
    with urlopen(request, timeout=30) as response:
        return hashlib.sha256(response.read().replace(b"\r\n", b"\n")).hexdigest()


def main() -> None:
    manifest = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {package["name"]: package for package in manifest["packages"]}
    mathlib = packages.get("mathlib")
    if not mathlib or mathlib.get("url") != MATHLIB_REPO or mathlib.get("rev") != MATHLIB_SHA:
        raise SystemExit("Mathlib dependency differs from the disclosed immutable source")
    if "lean_4" in packages:
        raise SystemExit("Directed-Topology must use the reviewed vendored source, not a second Lake checkout")
    if any(package.get("type") == "path" for package in manifest["packages"]):
        raise SystemExit("Lake manifest contains an undeclared path dependency")

    metadata = yaml.safe_load((ROOT / "formalization.yaml").read_text(encoding="utf-8"))
    related = metadata.get("related_formalizations", [])
    directed = next((item for item in related if DIRECTED_SHA in item.get("id", "")), None)
    mathlib_entry = next((item for item in related if MATHLIB_SHA in item.get("id", "")), None)
    prior = next((item for item in related if COMPUTATIONAL_PATHS_SHA in item.get("id", "")), None)
    if not directed or directed.get("relationship") != "builds-on":
        raise SystemExit("structured Directed-Topology builds-on relationship is missing")
    directed_note = directed.get("note", "")
    for required in ("Lean4/directed_van_kampen.lean", "Lean4/vendor-manifest.json", DIRECTED_SHA,
                     "vendored", "port"):
        if required not in directed_note:
            raise SystemExit("structured Directed-Topology provenance is incomplete: " + required)
    if not mathlib_entry or mathlib_entry.get("relationship") != "builds-on":
        raise SystemExit("structured Mathlib builds-on relationship is missing")
    if not prior or prior.get("relationship") != "independent":
        raise SystemExit("prior computational-path formalization is not distinguished as independent")

    provenance = (ROOT / "PROVENANCE.md").read_text(encoding="utf-8")
    for required in (DIRECTED_REPO, DIRECTED_SHA, MATHLIB_SHA, COMPUTATIONAL_PATHS_SHA,
                     "Lean4/directed_van_kampen.lean", "Lean4/LICENSE.md", "vendored"):
        if required not in provenance:
            raise SystemExit("PROVENANCE.md is incomplete: " + required)
    challenge = (ROOT / "Challenge.lean").read_text(encoding="utf-8")
    imports = re.findall(r"^import\s+(.+)$", challenge, re.MULTILINE)
    if not imports or any(not item.startswith("Mathlib.") for item in imports):
        raise SystemExit("Challenge import boundary is not Mathlib-only")
    all_lean = "\n".join(
        path.read_text(encoding="utf-8")
        for path in ROOT.rglob("*.lean")
        if ".lake" not in path.parts and ".git" not in path.parts
    )
    if "import ComputationalPaths" in all_lean:
        raise SystemExit("candidate sources import the prior computational-path repository")

    source_manifest_path = ROOT / "Lean4" / "vendor-manifest.json"
    source_manifest = json.loads(source_manifest_path.read_text(encoding="utf-8"))
    if source_manifest.get("repository") != DIRECTED_REPO or source_manifest.get("commit") != DIRECTED_SHA:
        raise SystemExit("vendored-source manifest does not name the disclosed repository commit")
    if not (ROOT / "Lean4" / "LICENSE.md").is_file() or "Copyright 2023 Dominique Lawson" not in (
        ROOT / "Lean4" / "LICENSE.md"
    ).read_text(encoding="utf-8"):
        raise SystemExit("upstream MIT license notice is missing from the vendored source")
    porting = (ROOT / "Lean4" / "PORTING.md").read_text(encoding="utf-8")
    changed = []
    seen = set()
    source_files = source_manifest.get("files", [])
    for item in source_files:
        relative = item.get("path", "")
        if not relative or relative in seen:
            raise SystemExit("vendored-source manifest has a missing or duplicate file path")
        seen.add(relative)
        local = ROOT / relative
        if not local.is_file() or sha256(local) != item.get("vendored_sha256"):
            raise SystemExit("vendored source differs from its recorded port hash: " + relative)
        upstream = item.get("upstream_sha256")
        if not re.fullmatch(r"[0-9a-f]{64}", upstream or ""):
            raise SystemExit("upstream source hash is malformed: " + relative)
        if upstream != item["vendored_sha256"]:
            changed.append(relative)
            if f"`{relative}`" not in porting:
                raise SystemExit("porting record omits changed upstream file: " + relative)
    with ThreadPoolExecutor(max_workers=8) as pool:
        remote_hashes = list(pool.map(lambda item: upstream_sha256(item, DIRECTED_SHA), source_files))
    for item, actual in zip(source_files, remote_hashes):
        if actual != item["upstream_sha256"]:
            raise SystemExit("vendored source baseline does not match the immutable upstream file: " + item["source_path"])
    if not any(item.get("path") == "Lean4/directed_van_kampen.lean" for item in source_manifest.get("files", [])):
        raise SystemExit("vendored-source manifest omits the imported theorem module")
    if len(changed) != 20:
        raise SystemExit(f"unexpected number of ported upstream files: {len(changed)}")
    print(f"Structured provenance and exact vendored-source hashes passed ({len(changed)} compatibility ports).")


if __name__ == "__main__":
    main()
