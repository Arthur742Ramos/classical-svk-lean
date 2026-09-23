# Verification record

This record keeps source builds, package checks, Palomar replay, independent
review, and any later intake or registration as separate gates.

## Current artifact

- Repository: <https://github.com/Arthur742Ramos/classical-svk-lean>
- Frozen candidate commit:
  `fbbcc347d3b544ef9b72ed89d15345fc7c75b5fc`
  (<https://github.com/Arthur742Ramos/classical-svk-lean/tree/fbbcc347d3b544ef9b72ed89d15345fc7c75b5fc>).
- Candidate `Challenge.lean` SHA-256:
  `5832240b656012cdb39a69c25cf4335221d08d95ec29f2393c9a07fd2f4a3038`.
- The repository head may be newer because this record can be updated in a
  documentation-only commit. The named candidate SHA is the verified artifact.
- Palomar intake, editorial acceptance, or registration: none.

The exact mechanical replay report lists generated `submission_id`
`7a5ba19d5cbd` and `existing_id: null`. That identifier is the workflow's
request ID, not a Palomar registry ID, intake receipt, or registration
authorization. The workflow prepared and checked an exact request without
submitting it.

## Current candidate gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Lean proof and package build | Passed | Local `lake build Challenge Solution` and the targeted `Lean4.directed_van_kampen` / `Lean4.all` builds passed. The exact-candidate hosted preflight also built `Challenge` and `Solution` on commit `fbbcc347…`. The final commit after the local build changed metadata only. |
| Statement match and Mathlib-only Challenge | Passed for exact candidate | Hosted package preflight and `python scripts/check-package.py`; the Challenge imports Mathlib only and matches the selected theorem. |
| Closed Challenge compiled-body audit | Passed for exact candidate | Hosted preflight ran `scripts/check-closed-statement.lean`; it checked seven compiler-generated proposition proofs and found no candidate-defined mathematical data. |
| Axiom and proof-hole audit | Passed for exact candidate | Hosted preflight passed `scripts/check-axioms.py`; the selected theorem uses only `Classical.choice`, `Quot.sound`, and `propext`, and the solution has no proof hole. |
| Schema and structured provenance | Passed for exact candidate | Hosted preflight passed package and provenance checks. Remote source hashes matched for 20 compatibility ports and the one extracted helper, with the source commits and MIT notice recorded. |
| Pinned Palomar renderer and Linux Landrun core-notation audit | Passed for exact candidate SHA | [Renderer run 35914428669](https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35914428669); report status `pass`, stage `complete`, Challenge hash matches above, renderer `56689ef65c4e97dcfa31b3c166f492337fb4976b`, and Landrun `811cfff51ceaf3d9843708aa6d22e9b84ccac8b4`. |
| Pinned Comparator, NanoDa, and Palomar mechanical replay | Passed for exact candidate SHA | [Mechanical run 35914428746](https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35914428746); stage `complete`, status `pass`, no warnings, and `existing_id: null`. |
| Independent mathematical review | Not performed | No independent reviewer is claimed. |
| Palomar editorial acceptance, intake, or registration | Not performed | Verification prepared no intake and registered no entry. |

## Historical candidates and receipts

Candidate `a3927226a3a18c87194bfb755308bab5d8fb7dac` is historical. Its source
proof was the same direct path-descent construction, but a final metadata review
found a stale description of the packaged directed theorem as a dependency. Its
in-progress hosted attempts were superseded by the corrected exact candidate
`fbbcc347…` and were cancelled:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35914153625>
- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35914153662>

Candidate `856159930dbdaa37aaa60978e76274cb1e84e96c` is also historical. It
passed the pinned renderer and mechanical replay, but its selected proof
invoked the packaged `DirectedVanKampen.directed_van_kampen` theorem, so those
receipts do not verify the direct path-descent proof in the current candidate:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35908998653>
- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35909014062>

Earlier receipts are historical as well. The source-port candidate
`aaddc59c70ae9354fbc374b6e4bc9f65a5da494e` passed mechanical checks but its
renderer could not resolve a legacy ProofWidgets release. Candidate
`741f581c18cd0c301e1dc9e40e72bdbf4e7ee258` had a renderer workspace-setup
failure and a cancelled mechanical dispatch. The initial candidate
`661ae65de04ec3ef1ae7d9a07e919312f0d4d776` used an incompatible Lean 4.6 setup.
Their historical workflow receipts are:

- `aaddc59…` renderer:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35905945026>
- `aaddc59…` mechanical:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35905944938>
- `741f581…` renderer:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35907701666>
- `741f581…` mechanical:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35907730069>
- `661ae65…` renderer:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35880932641>
- `661ae65…` mechanical:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35880932600>

The current proof uses the attributed source commit
`009529606c66d37ef93b4b81b8587f71ce4d2c56` for path-subdivision and
homotopy-grid helpers, with Mathlib pinned to
`8f9d9cff6bd728b17a24e163c9402775d9e6a365`. The current proof directly
constructs the descent universal property and transfers it to Mathlib's
ordinary continuous-path groupoid through the proved universal-preorder
equivalence. It does not invoke the packaged directed theorem.
