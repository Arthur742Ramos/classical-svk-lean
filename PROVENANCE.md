# Provenance

## Selected result

The selected declaration is
ClassicalSVK.seifert_van_kampen_groupoid in Solution.lean. Its proposition is
the pushout square for Mathlib's ordinary fundamental groupoids induced by the
inclusions of U ∩ V, U, and V into a space X with an open two-set cover.

## Formalization dependencies

- Mathlib is pinned to commit
  a6a17daf8c81a2c35aff2e43a431a7c591fa708a. The Challenge imports only
  Mathlib.
- Directed-Topology-Lean-4 is pinned to commit
  009529606c66d37ef93b4b81b8587f71ce4d2c56. The proof imports its
  Lean4.directed_van_kampen module. No dependency source is copied or modified
  in this repository.
- The proof and its category-equivalence bridge are new source files in this
  focused repository. They are not copied from the earlier computational-path
  development.

The bridge equips each space with the indiscrete preorder, identifies the
directed path quotient with Mathlib's continuous path quotient, proves this
identification natural for continuous inclusions, and transports the existing
directed pushout. The imported directed theorem is an explicit formalization
dependency, not a result claimed as new here.

## Related formalizations

- The immutable snapshot
  https://github.com/Dominique-Lawson/Directed-Topology-Lean-4/tree/009529606c66d37ef93b4b81b8587f71ce4d2c56
  contains the directed van Kampen theorem in
  Lean4/directed_van_kampen.lean. This entry builds on that theorem via the
  universal-preorder specialization just described.
- The immutable snapshot
  https://github.com/leanprover-community/mathlib4/tree/a6a17daf8c81a2c35aff2e43a431a7c591fa708a
  supplies the ordinary path fundamental groupoid, induced functors, and
  category-theoretic pushout API.
- The immutable snapshot
  https://github.com/Arthur742Ramos/ComputationalPathsLean/tree/257c659b7973aeda900d86a5da73b208712c7523
  contains independent computational-path SVK developments, including
  based-point equivalences and presentation-based results. No source or proof
  from that repository is reused. The selected result here is the actual
  topological groupoid pushout for an arbitrary open cover, with every point
  as an object and no connectedness or basepoint hypothesis.
- The Archive of Formal Proofs entry
  https://isa-afp.org/entries/Seifert-Van-Kampen.html formalizes a based
  fundamental-group theorem under path-connectedness assumptions. It is
  related background only; this repository reuses none of its Isabelle source.

## Licensing and attribution

This repository's files are licensed under Apache-2.0. The directed-topology
dependency remains under the MIT license carried by its pinned repository;
Mathlib retains its own license. Both are fetched as Lake dependencies, not
vendored. Their authors and immutable revisions are listed in
formalization.yaml.
