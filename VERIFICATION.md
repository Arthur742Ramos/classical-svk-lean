# Verification record

This record keeps the source build, package checks, renderer, mechanical
verification, independent review, and any Palomar intake as distinct gates.

## Current artifact

- Repository: <https://github.com/Arthur742Ramos/classical-svk-lean>
- The formerly frozen candidate `856159930dbdaa37aaa60978e76274cb1e84e96c`
  is historical because its selected proof invoked the packaged
  `DirectedVanKampen.directed_van_kampen` theorem. It is not the replacement
  candidate.
- The replacement source directly constructs the descent functor and pushout
  universal property from the attributed path-subdivision and homotopy-grid
  helpers. Its exact candidate SHA and hosted gate results will be recorded
  here after pinned replay.
- Palomar intake or registration: none.

The historical candidate's mechanical report contains a generated `submission_id`
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

None of these earlier receipts establishes a gate for the replacement
candidate.

## Historical candidate gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Full historical candidate proof and package build | Passed, historical only | The prior commit built with Lean 4.28.0 and Mathlib commit `8f9d9cff6bd728b17a24e163c9402775d9e6a365`; this does not verify the replacement proof. |
| Challenge/solution statement match and Mathlib-only Challenge boundary | Passed | `python scripts/check-package.py` and the hosted preflight passed; Challenge imports Mathlib only and agrees with the selected theorem. |
| Closed Challenge compiled-body audit | Passed | `lake env lean scripts/check-closed-statement.lean` and hosted preflight passed; the audit checked seven compiler-generated proof helpers and found no candidate-defined mathematical data. |
| Axiom and proof-hole audit | Passed | `python scripts/check-axioms.py` and hosted preflight passed; the theorem uses only `propext`, `Classical.choice`, and `Quot.sound`, and `Solution.lean` has no proof-hole token. |
| Schema, source hashes, and structured provenance | Passed, historical only | The prior candidate's source-port checks passed. |
| Pinned Palomar renderer with Linux Landrun core-notation audit | Passed for historical SHA only | [Renderer run 35908998653](https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35908998653); it does not verify the replacement candidate. |
| Pinned Comparator, NanoDa, and Palomar mechanical replay | Passed for historical SHA only | [Mechanical run 35909014062](https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35909014062); it does not verify the replacement candidate. |
| Independent mathematical review | Not performed | No independent reviewer is claimed. |
| Palomar editorial acceptance, intake, or registration | Not performed | These historical mechanical checks did not submit or register a Palomar entry. |

The historical candidate used directed-topology source commit
`009529606c66d37ef93b4b81b8587f71ce4d2c56`; Mathlib is pinned to
`8f9d9cff6bd728b17a24e163c9402775d9e6a365`. Both hosted reports name the
historical candidate `856159930dbdaa37aaa60978e76274cb1e84e96c`. The theorem is the ordinary Mathlib continuous-path
groupoid pushout; its proof transfers the established directed theorem through
the universal-preorder equivalence described in [RESEARCH_INTEREST.md](RESEARCH_INTEREST.md).
