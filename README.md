# Classical Seifert–van Kampen theorem in Mathlib

This Lean project proves that for every topological space \(X\) and open cover
\(X = U \cup V\), the square of inclusion-induced functors

\[
\Pi_1(U \cap V) \longrightarrow \Pi_1(U),\quad
\Pi_1(U \cap V) \longrightarrow \Pi_1(V),\quad
\Pi_1(U),\Pi_1(V) \longrightarrow \Pi_1(X)
\]

is a pushout in `Cat`. The fundamental groupoids are Mathlib's ordinary
continuous-path groupoids. The statement has no chosen basepoint, path
connectedness assumptions, or separation assumptions; it retains every point
as an object and therefore also handles a disconnected intersection.

The proof gives each space the indiscrete preorder. Under that preorder every
continuous path is directed, and every endpoint-preserving path homotopy is a
directed homotopy. The project proves inverse equivalences between the
directed fundamental category and Mathlib's fundamental groupoid, proves
naturality for inclusions, and transports the pinned directed van Kampen
pushout to the ordinary topological groupoid.

This formalization builds on the directed van Kampen theorem by Basold, Bruin,
and Lawson. It does not claim that the classical theorem is new, or that this
is an independent proof of the directed theorem. The precise relationship and
the comparison with the earlier computational-path formalization are recorded
in [PROVENANCE.md](PROVENANCE.md) and [RESEARCH_INTEREST.md](RESEARCH_INTEREST.md).

## Build and audit

With the pinned Lean toolchain installed, run:

```sh
lake build Challenge Solution
lake env lean scripts/check-closed-statement.lean
python scripts/check-axioms.py
python scripts/check-package.py
python scripts/check-provenance.py
```

`Challenge.lean` imports only Mathlib and contains the selected statement.
`Solution.lean` independently repeats the statement and proves it using the
Mathlib fundamental groupoid. The Comparator configuration selects
`ClassicalSVK.completeStatement` and
`ClassicalSVK.seifert_van_kampen_groupoid`.

The workflows run the pinned Palomar renderer (including its core-notation
audit under Linux Landrun) and the pinned Palomar mechanical verifier. They
prepare verification reports only; they do not create an intake or register a
Palomar entry.

## Status

The Lean proof has compiled in the exact Lean 4.6.0-rc1 and Mathlib dependency
environment used by the pinned directed formalization. The fresh candidate
repository's hosted Linux build, renderer, Comparator/NanoDa replay, and
research review are tracked separately in [VERIFICATION.md](VERIFICATION.md).
No Palomar intake or registration is claimed.
