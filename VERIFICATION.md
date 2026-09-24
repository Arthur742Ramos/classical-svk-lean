# Verification record

This record keeps source builds, package checks, Palomar replay, independent
review, and any later intake or registration as separate gates.

## Current artifact

- Repository: <https://github.com/Arthur742Ramos/classical-svk-lean>
- Lean toolchain: `leanprover/lean4:v4.35.0-rc2`.
- Mathlib source commit:
  `065356127b1dc0016f66b7283ce0ce2c4055aa55`.
- Candidate `Challenge.lean` SHA-256:
  `4a90a555ca68f41472d3f1f4ba00887966d95560f733e1077856ff705c6fbe47`.
- The exact source SHA and challenge digest are recorded by the current
  [renderer workflow](https://github.com/Arthur742Ramos/classical-svk-lean/actions/workflows/palomar-render.yml)
  and
  [mechanical workflow](https://github.com/Arthur742Ramos/classical-svk-lean/actions/workflows/palomar-mechanical.yml).
  Before intake, use the same full source SHA in both successful run reports.
- Palomar intake, editorial acceptance, or registration: none.

The mechanical workflow prepares and checks a request without submitting it.
Its generated request ID is not a Palomar registry ID, intake receipt, or
registration authorization.

## Current candidate gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Lean proof and package build | Passed on exact source SHA | `lake build Challenge Solution` passed locally after the Lean 4.35 port; the hosted mechanical workflow also builds the package on its exact candidate SHA. |
| Statement match and Mathlib-only Challenge | Passed on exact source SHA | Hosted package preflight runs `scripts/check-package.py`; the Challenge imports Mathlib only and matches the selected theorem. |
| Closed Challenge compiled-body audit | Passed on exact source SHA | Hosted preflight runs `scripts/check-closed-statement.lean`; it checks seven compiler-generated proposition proofs and rejects candidate-defined mathematical data. |
| Axiom and proof-hole audit | Passed on exact source SHA | Hosted preflight runs `scripts/check-axioms.py`; the selected theorem uses only `Classical.choice`, `Quot.sound`, and `propext`, with no proof hole. |
| Schema and structured provenance | Passed on exact source SHA | Hosted preflight runs package and provenance checks. It checks all 26 compatibility ports and the extracted helper against pinned source hashes and preserves the upstream MIT notice. |
| Pinned Palomar renderer and Linux Landrun core-notation audit | Passed on exact source SHA | The [renderer workflow](https://github.com/Arthur742Ramos/classical-svk-lean/actions/workflows/palomar-render.yml) uses renderer `56689ef65c4e97dcfa31b3c166f492337fb4976b` and Landrun `811cfff51ceaf3d9843708aa6d22e9b84ccac8b4`; confirm the passing run's full source SHA and Challenge digest. |
| Pinned Comparator, NanoDa, and Palomar mechanical replay | Passed on exact source SHA | The [mechanical workflow](https://github.com/Arthur742Ramos/classical-svk-lean/actions/workflows/palomar-mechanical.yml) uses Comparator `575674928e239f5bc452aab72d1dd7b0f1326494`, NanoDa `68d5ca9db226849b41a6fff59d796ff19d0a8840`, and Landrun `811cfff51ceaf3d9843708aa6d22e9b84ccac8b4`; confirm the passing run's full source SHA. |
| Independent mathematical review | Not performed | No independent reviewer is claimed. |
| Palomar editorial acceptance, intake, or registration | Not performed | Verification prepared no intake and registered no entry. |

## Historical candidates and receipts

Candidate `fbbcc347d3b544ef9b72ed89d15345fc7c75b5fc` is historical because it
uses Lean 4.28, below Palomar's minimum. Its renderer and mechanical receipts
do not satisfy the current Lean requirement:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35914428669>
- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35914428746>

Candidate `189a004e131a189188dbd8872e34932fde11947f` upgraded Lean and passed
rendering, but its mechanical workflow stopped while building Lean4Export from
an incompatible cached toolchain, before Palomar's verifier ran. Candidate
`0482f00a5674c36e7658f4f8d720a366eb7ac63a` fixed the cache key and checks out
the exact helper commit before building it. Its successful runs are historical
once a later exact-SHA candidate is selected:

- Historical renderer run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35943173858>
- Historical mechanical run:
  <https://github.com/Arthur742Ramos/classical-svk-lean/actions/runs/35943152379>

Candidate `a3927226a3a18c87194bfb755308bab5d8fb7dac` is historical. Its source
proof was the same direct path-descent construction, but a final metadata review
found a stale description of the packaged directed theorem as a dependency. Its
in-progress hosted attempts were superseded and were cancelled:

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
`065356127b1dc0016f66b7283ce0ce2c4055aa55`. It directly constructs the
descent universal property and transfers it to Mathlib's ordinary
continuous-path groupoid through the proved universal-preorder equivalence.
It does not invoke the packaged directed theorem. Older port-count and
Mathlib-pin details refer only to historical candidates; the current source
has 26 compatibility ports and is checked with Lean 4.35.0-rc2.
