"""Check proof holes and the exact axiom surface of the selected result."""

from pathlib import Path
import re
import subprocess


ROOT = Path(__file__).resolve().parents[1]
DECLARATION = "ClassicalSVK.seifert_van_kampen_groupoid"
ALLOWED = {"propext", "Classical.choice", "Quot.sound"}


def run(source: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["lake", "env", "lean", "--stdin"],
        cwd=ROOT,
        input=source,
        text=True,
        capture_output=True,
    )


def main() -> None:
    solution = (ROOT / "Solution.lean").read_text(encoding="utf-8")
    if re.search(r"\b(sorry|admit|axiom)\b", solution):
        raise SystemExit("proof-hole token found in Solution.lean")

    result = run(f"import Solution\n#print axioms {DECLARATION}\n")
    if result.returncode:
        raise SystemExit(result.stdout + result.stderr)
    output = result.stdout + result.stderr
    match = re.search(
        rf"'{re.escape(DECLARATION)}' depends on axioms: \[([^\]]*)\]",
        output,
        re.DOTALL,
    )
    if match is None:
        raise SystemExit("Lean did not report the selected theorem's axioms")
    axioms = {
        item.strip()
        for item in match.group(1).replace("\n", " ").split(",")
        if item.strip()
    }
    if axioms != ALLOWED:
        raise SystemExit(f"unexpected axiom surface: {sorted(axioms)}")
    print(f"{DECLARATION} uses only {', '.join(sorted(ALLOWED))}.")


if __name__ == "__main__":
    main()
