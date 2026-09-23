"""Reconcile Lake pins, structured provenance, and the source record."""

from pathlib import Path
import json
import re

import yaml


ROOT = Path(__file__).resolve().parents[1]
DIRECTED_REPO = "https://github.com/Dominique-Lawson/Directed-Topology-Lean-4.git"
DIRECTED_SHA = "009529606c66d37ef93b4b81b8587f71ce4d2c56"
MATHLIB_REPO = "https://github.com/leanprover-community/mathlib4.git"
MATHLIB_SHA = "a6a17daf8c81a2c35aff2e43a431a7c591fa708a"
COMPUTATIONAL_PATHS_SHA = "257c659b7973aeda900d86a5da73b208712c7523"


def main() -> None:
    manifest = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {package["name"]: package for package in manifest["packages"]}
    directed = packages.get("lean_4")
    mathlib = packages.get("mathlib")
    if not directed or directed.get("url") != DIRECTED_REPO or directed.get("rev") != DIRECTED_SHA:
        raise SystemExit("Directed-Topology dependency differs from the disclosed immutable source")
    if not mathlib or mathlib.get("url") != MATHLIB_REPO or mathlib.get("rev") != MATHLIB_SHA:
        raise SystemExit("Mathlib dependency differs from the disclosed immutable source")
    if any(package.get("type") == "path" for package in manifest["packages"]):
        raise SystemExit("Lake manifest contains a path dependency")

    metadata = yaml.safe_load((ROOT / "formalization.yaml").read_text(encoding="utf-8"))
    related = metadata.get("related_formalizations", [])
    directed_entry = next((item for item in related if DIRECTED_SHA in item.get("id", "")), None)
    mathlib_entry = next((item for item in related if MATHLIB_SHA in item.get("id", "")), None)
    prior_entry = next(
        (item for item in related if COMPUTATIONAL_PATHS_SHA in item.get("id", "")),
        None,
    )
    if not directed_entry or directed_entry.get("relationship") != "builds-on":
        raise SystemExit("formalization.yaml is missing the structured directed source relationship")
    if "Lean4/directed_van_kampen.lean" not in directed_entry.get("note", ""):
        raise SystemExit("formalization.yaml does not identify the imported directed theorem source")
    if not mathlib_entry or mathlib_entry.get("relationship") != "builds-on":
        raise SystemExit("formalization.yaml is missing the structured Mathlib relationship")
    if not prior_entry or prior_entry.get("relationship") != "independent":
        raise SystemExit("prior computational-path formalization is not distinguished as independent")

    provenance = (ROOT / "PROVENANCE.md").read_text(encoding="utf-8")
    for required in (DIRECTED_SHA, MATHLIB_SHA, COMPUTATIONAL_PATHS_SHA,
                     "Lean4/directed_van_kampen.lean", "No source or proof"):
        if required not in provenance:
            raise SystemExit("PROVENANCE.md is incomplete: " + required)
    challenge = (ROOT / "Challenge.lean").read_text(encoding="utf-8")
    imports = re.findall(r"^import\s+(.+)$", challenge, re.MULTILINE)
    if not imports or any(not item.startswith("Mathlib.") for item in imports):
        raise SystemExit("Challenge import boundary is not Mathlib-only")
    if "import ComputationalPaths" in "\n".join(
        path.read_text(encoding="utf-8")
        for path in ROOT.rglob("*.lean")
        if ".lake" not in path.parts
    ):
        raise SystemExit("candidate sources import the prior computational-path repository")
    print("Immutable dependency pins and structured provenance reconciled.")


if __name__ == "__main__":
    main()
