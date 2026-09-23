"""Fail-closed source, Comparator, pin, metadata, and proof-boundary checks."""

from pathlib import Path
import json
import re
import tomllib
import urllib.request

import jsonschema
import yaml


ROOT = Path(__file__).resolve().parents[1]
MATHLIB_SHA = "8f9d9cff6bd728b17a24e163c9402775d9e6a365"
DIRECTED_SHA = "009529606c66d37ef93b4b81b8587f71ce4d2c56"
THEOREM = "ClassicalSVK.seifert_van_kampen_groupoid"
DEFINITION = "ClassicalSVK.completeStatement"
ALLOWED_AXIOMS = ["propext", "Classical.choice", "Quot.sound"]
SCHEMA = (
    "https://raw.githubusercontent.com/mathlib-initiative/formalization.yaml/"
    "main/schema/v0.4.schema.json"
)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(message)


def without_comments(source: str) -> str:
    result: list[str] = []
    depth = 0
    index = 0
    while index < len(source):
        if source.startswith("/-", index):
            depth += 1
            result.append("  ")
            index += 2
        elif depth and source.startswith("-/", index):
            depth -= 1
            result.append("  ")
            index += 2
        elif depth:
            result.append("\n" if source[index] == "\n" else " ")
            index += 1
        elif source.startswith("--", index):
            while index < len(source) and source[index] != "\n":
                result.append(" ")
                index += 1
        else:
            result.append(source[index])
            index += 1
    require(depth == 0, "unclosed Lean block comment")
    return "".join(result)


def statement_block(source: str) -> str:
    start = source.index("def completeStatement : Prop :=")
    marker = "\ntheorem seifert_van_kampen_groupoid"
    end = source.find(marker, start)
    require(end >= 0, "selected theorem is missing after completeStatement")
    return source[start:end].strip()


def main() -> None:
    required = [
        "Challenge.lean",
        "Solution.lean",
        "comparator.json",
        "formalization.yaml",
        "lakefile.lean",
        "lake-manifest.json",
        "lean-toolchain",
        "LICENSE",
        "README.md",
        "PROVENANCE.md",
        "RESEARCH_INTEREST.md",
        "AGENT-CONTRIBUTION.md",
        "VERIFICATION.md",
        "ClassicalSVK/Bridge/Categories.lean",
        "ClassicalSVK/Bridge/Naturality.lean",
        "ClassicalSVK/Bridge/Naturality2.lean",
        "ClassicalSVK/Bridge/Iso.lean",
        "ClassicalSVK/Pushout.lean",
        "Lean4.lean",
        "Lean4/directed_van_kampen.lean",
        "Lean4/LICENSE.md",
        "Lean4/PORTING.md",
        "Lean4/vendor-manifest.json",
        "scripts/check-closed-statement.lean",
        "scripts/check-axioms.py",
        "scripts/check-provenance.py",
    ]
    for relative in required:
        path = ROOT / relative
        require(path.is_file() and not path.is_symlink(), f"missing regular file: {relative}")

    challenge = (ROOT / "Challenge.lean").read_text(encoding="utf-8")
    solution = (ROOT / "Solution.lean").read_text(encoding="utf-8")
    challenge_code = without_comments(challenge)
    solution_code = without_comments(solution)
    imports = re.findall(r"^(?:public )?import\s+(.+)$", challenge_code, re.MULTILINE)
    require(
        imports and all(item.startswith("Mathlib.") or item == "Mathlib" for item in imports),
        "Challenge must import Mathlib only",
    )
    require(len(re.findall(r"\bsorry\b", challenge_code)) == 1,
            "Challenge must contain exactly one intentional theorem hole")
    require(len(re.findall(r"^theorem\s+", challenge_code, re.MULTILINE)) == 1,
            "Challenge must expose exactly one theorem")
    require(
        not re.search(r"\b(sorry|admit|axiom)\b", solution_code),
        "proof-hole token found in Solution",
    )
    require("import Challenge" not in solution_code,
            "Solution must not import the Challenge hole")
    require(
        statement_block(challenge) == statement_block(solution),
        "Challenge and Solution completeStatement definitions differ",
    )
    require(len(challenge.splitlines()) <= 1000 and len(challenge.encode()) <= 100 * 1024,
            "Challenge exceeds Palomar's hard size limit")

    comparator = json.loads((ROOT / "comparator.json").read_text(encoding="utf-8"))
    require(
        comparator == {
            "challenge_module": "Challenge",
            "solution_module": "Solution",
            "theorem_names": [THEOREM],
            "definition_names": [DEFINITION],
            "permitted_axioms": ALLOWED_AXIOMS,
            "enable_nanoda": True,
        },
        "Comparator selection or trust boundary changed",
    )

    lakefile = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
    require(MATHLIB_SHA in lakefile and "mathlib4.git" in lakefile,
            "Lakefile must pin the selected Mathlib commit by full SHA")
    manifest = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
    require(not any(package.get("type") == "path" for package in manifest["packages"]),
            "Lake manifest must not contain path dependencies")
    packages = {package["name"]: package for package in manifest["packages"]}
    mathlib = packages.get("mathlib", {})
    require(mathlib.get("rev") == MATHLIB_SHA and mathlib.get("type") == "git",
            "Mathlib manifest pin changed")
    require((ROOT / "lean-toolchain").read_text(encoding="utf-8").strip()
            == "leanprover/lean4:v4.28.0", "Lean toolchain pin changed")

    metadata_text = (ROOT / "formalization.yaml").read_text(encoding="utf-8")
    metadata = yaml.safe_load(metadata_text)
    with urllib.request.urlopen(SCHEMA, timeout=30) as response:
        schema = json.load(response)
    jsonschema.Draft7Validator.check_schema(schema)
    jsonschema.Draft7Validator(schema).validate(metadata)
    require(metadata.get("version") == "v0.4", "formalization metadata version changed")
    require(metadata["status"]["sorry_count"] == 0, "metadata proof-hole count is not zero")
    require(metadata["status"]["main_results"][0]["declaration"] == THEOREM,
            "main-result metadata declaration changed")

    related = metadata.get("related_formalizations", [])
    directed_id = next((entry for entry in related if DIRECTED_SHA in entry["id"]), None)
    mathlib_id = next((entry for entry in related if MATHLIB_SHA in entry["id"]), None)
    prior_id = next((entry for entry in related
                     if "ComputationalPathsLean/tree/257c659b7973aeda900d86a5da73b208712c7523"
                     in entry["id"]), None)
    require(directed_id is not None and directed_id.get("relationship") == "builds-on",
            "structured Directed-Topology provenance is missing")
    require("Lean4/directed_van_kampen.lean" in directed_id.get("note", ""),
            "Directed-Topology source module is not recorded")
    require("Lean4/vendor-manifest.json" in directed_id.get("note", ""),
            "vendored Directed-Topology source manifest is not recorded")
    require(mathlib_id is not None and mathlib_id.get("relationship") == "builds-on",
            "structured Mathlib provenance is missing")
    require(prior_id is not None and prior_id.get("relationship") == "independent",
            "prior computational-path formalization is not explicitly distinguished")

    for path in ROOT.rglob("*"):
        if ".lake" in path.parts or ".git" in path.parts:
            continue
        require(not path.is_symlink(), f"source tree contains a symlink: {path.relative_to(ROOT)}")
        if path.is_file():
            require(path.suffix not in {
                ".olean", ".ilean", ".ir", ".trace", ".o", ".a", ".so", ".dll",
                ".dylib", ".bc", ".pyc",
            }, f"compiled artifact outside the build/cache: {path.relative_to(ROOT)}")
    print("Package shape, metadata schema, immutable pins, statement boundary, and provenance passed.")


if __name__ == "__main__":
    main()
