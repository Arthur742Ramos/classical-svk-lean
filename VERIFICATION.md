# Verification record

This file records distinct evidence for the source proof, package boundary,
Palomar renderer, and Palomar mechanical verifier. A successful build alone is
not treated as a renderer or mechanical pass.

## Current candidate

- Repository commit: pending initial public repository commit.
- Palomar intake: none. Preparation does not create an intake or register an
  entry.

## Gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Full proof in the pinned Lean 4.6.0-rc1 / Mathlib environment | Passed by sequential module compilation in the reference checkout; exact candidate replay pending | Candidate Lean modules, including Solution, compiled against the exact locked Mathlib and directed-topology sources. The hosted Linux workflow will run `lake build Challenge Solution` on the immutable candidate commit. |
| Candidate package build on Linux | Pending | Must be run against the final immutable candidate commit. |
| Axiom and proof-hole audit | Passed locally | `scripts/check-axioms.py`: the selected theorem uses only `propext`, `Classical.choice`, and `Quot.sound`. |
| Closed Challenge statement-body audit | Passed locally | `scripts/check-closed-statement.lean`: checked six generated proposition proofs and found no reachable candidate-defined mathematical data. |
| Package/schema and structured provenance checks | Passed locally | `scripts/check-package.py` and `scripts/check-provenance.py`. |
| Pinned Palomar Challenge renderer, including core-notation audit under Linux Landrun | Pending | GitHub Actions workflow palomar-render.yml |
| Pinned Palomar Comparator, Lean4Export, NanoDa, and mechanical verifier | Pending | GitHub Actions workflow palomar-mechanical.yml |
| Independent mathematical review | Not performed | No independent reviewer is claimed. |
| Palomar editorial review or registration | Not performed | No intake or registration is claimed. |

The full upstream dependency is pinned to commit
009529606c66d37ef93b4b81b8587f71ce4d2c56 and Mathlib to commit
a6a17daf8c81a2c35aff2e43a431a7c591fa708a. Hosted release evidence must name
the exact candidate commit and must not be inferred from another checkout.
