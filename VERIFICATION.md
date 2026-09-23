# Verification record

This record keeps the source build, package checks, renderer, mechanical
verification, independent review, and any Palomar intake as distinct gates.

## Current artifact

- Repository: <https://github.com/Arthur742Ramos/classical-svk-lean>
- Frozen candidate commit: `856159930dbdaa37aaa60978e76274cb1e84e96c`
  (<https://github.com/Arthur742Ramos/classical-svk-lean/tree/856159930dbdaa37aaa60978e76274cb1e84e96c>).
- Candidate `Challenge.lean` SHA-256: `5832240b656012cdb39a69c25cf4335221d08d95ec29f2393c9a07fd2f4a3038`.
- This record can be newer than the frozen candidate because its updates are
  documentation-only. A later default-branch head is not implicitly a new
  submission artifact.
- Palomar intake or registration: none.

The candidate's mechanical report contains a generated `submission_id`
(`5b2a1735d6c8`). It is the deterministic request identifier derived from the
workflow run ID, not a Palomar registry ID, intake receipt, or authorization to
register the result. The report also has `existing_id: null`.

## Historical candidates

The initial commit `661ae65de04ec3ef1ae7d9a07e919312f0d4d776` is historical.
Its workflows used an incompatible Lean 4.6 setup and did not verify the
ported source now in the frozen candidate:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35880932641>
- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35880932600>

The source-port candidate `aaddc59c70ae9354fbc374b6e4bc9f65a5da494e` is also
historical. Its mechanical run passed, but its renderer could not resolve the
legacy ProofWidgets release from the network-disabled cache-discovery sandbox:

- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35905944938>
- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35905945026>

Candidate `741f581c18cd0c301e1dc9e40e72bdbf4e7ee258` is historical as well. Its
renderer failed because a workflow workaround created the renderer workspace
before the pinned renderer expected to create it; its mechanical dispatch was
canceled while still in preflight:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35907701666>
- Canceled historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35907730069>

None of these earlier receipts establishes a gate for the frozen candidate.

## Gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Full candidate proof and package build | Passed locally and in hosted preflight | `lake build Challenge Solution` succeeded with Lean 4.28.0 and Mathlib commit `8f9d9cff6bd728b17a24e163c9402775d9e6a365` (3,205 local build jobs); hosted preflight passed on the exact candidate SHA. |
| Challenge/solution statement match and Mathlib-only Challenge boundary | Passed | `python scripts/check-package.py` and the hosted preflight passed; Challenge imports Mathlib only and agrees with the selected theorem. |
| Closed Challenge compiled-body audit | Passed | `lake env lean scripts/check-closed-statement.lean` and hosted preflight passed; the audit checked seven compiler-generated proof helpers and found no candidate-defined mathematical data. |
| Axiom and proof-hole audit | Passed | `python scripts/check-axioms.py` and hosted preflight passed; the theorem uses only `propext`, `Classical.choice`, and `Quot.sound`, and `Solution.lean` has no proof-hole token. |
| Schema, source hashes, and structured provenance | Passed | Package and provenance scripts passed locally and in hosted preflight, including remote hash comparisons for all 20 compatibility-ported source files. |
| Pinned Palomar renderer with Linux Landrun core-notation audit | Passed for exact candidate SHA | [Renderer run 35908998653](https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35908998653); report status `pass`, renderer `56689ef65c4e97dcfa31b3c166f492337fb4976b`, Landrun `811cfff51ceaf3d9843708aa6d22e9b84ccac8b4`. |
| Pinned Comparator, NanoDa, and Palomar mechanical replay | Passed for exact candidate SHA | [Mechanical run 35909014062](https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35909014062); stage `complete`, status `pass`, no warnings. It does not create an intake or registration. |
| Independent mathematical review | Not performed | No independent reviewer is claimed. |
| Palomar editorial acceptance, intake, or registration | Not performed | Mechanical verification is complete; no Palomar entry has been submitted or registered. |

The directed-topology source commit is
`009529606c66d37ef93b4b81b8587f71ce4d2c56`; Mathlib is pinned to
`8f9d9cff6bd728b17a24e163c9402775d9e6a365`. Both hosted reports name the
frozen candidate SHA above. The theorem is the ordinary Mathlib continuous-path
groupoid pushout; its proof transfers the established directed theorem through
the universal-preorder equivalence described in [RESEARCH_INTEREST.md](RESEARCH_INTEREST.md).
