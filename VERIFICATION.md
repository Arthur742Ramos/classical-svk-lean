# Verification record

This record keeps the source build, package checks, renderer, mechanical
verification, independent review, and any Palomar intake as distinct gates.

## Current artifact

- Repository: <https://github.com/Arthur742Ramos/classical-svk-lean>
- Candidate commit: pending the fresh verified-source commit.
- Palomar intake or registration: none.

## Historical candidate

The initial commit `661ae65de04ec3ef1ae7d9a07e919312f0d4d776` is historical.
Its workflows used an incompatible Lean 4.6 setup and did not verify the
current ported source:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35880932641>
- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35880932600>

Those receipts do not establish any gate for the replacement commit.

## Gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Full candidate proof and package build | Passed locally | `lake build Challenge Solution` completed successfully in this checkout with Lean 4.28.0 and Mathlib commit `8f9d9cff6bd728b17a24e163c9402775d9e6a365` (3,205 build jobs). |
| Challenge/solution statement match and Mathlib-only Challenge boundary | Passed locally | `python scripts/check-package.py`; Challenge imports Mathlib only and agrees with the selected theorem. |
| Closed Challenge compiled-body audit | Passed locally | `lake env lean scripts/check-closed-statement.lean`; checked seven compiler-generated proof helpers and found no candidate-defined mathematical data. |
| Axiom and proof-hole audit | Passed locally | `python scripts/check-axioms.py`; the theorem uses only `propext`, `Classical.choice`, and `Quot.sound`, and `Solution.lean` has no proof-hole token. |
| Schema, source hashes, and structured provenance | Passed locally | Package and provenance scripts passed, including remote hash comparisons for all 20 compatibility-ported source files. |
| Pinned Palomar renderer with Linux Landrun core-notation audit | Pending replacement commit | `.github/workflows/palomar-render.yml`; must pass against the exact candidate SHA. |
| Pinned Comparator, NanoDa, and Palomar mechanical replay | Pending replacement commit | `.github/workflows/palomar-mechanical.yml`; this does not itself create an intake. |
| Independent mathematical review | Not performed | No independent reviewer is claimed. |
| Palomar editorial acceptance, intake, or registration | Not performed | Preparation alone does not register an entry. |

The directed-topology source commit is
`009529606c66d37ef93b4b81b8587f71ce4d2c56`; Mathlib is pinned to
`8f9d9cff6bd728b17a24e163c9402775d9e6a365`. All hosted release evidence must
refer to the replacement artifact's exact commit.
