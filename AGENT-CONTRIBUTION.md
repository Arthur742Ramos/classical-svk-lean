# Contribution and authorship record

Arthur Freitas Ramos requested and is responsible for this focused
formalization repository. AI assistance was used for proof engineering,
literature/provenance review, and package preparation. The AI agent is not
listed as an author.

The selected theorem states that the fundamental groupoids of the actual
topological subspaces in an arbitrary open two-set cover form a pushout in
Cat. It uses Mathlib's ordinary continuous-path fundamental groupoid. The
proof reuses the attributed interval-subdivision and homotopy-grid helper
construction from the pinned directed-topology project, specialized via an
explicit equivalence for the indiscrete preorder. It directly constructs and
assembles the descent universal property; it does not invoke that project's
packaged directed Van Kampen theorem.

The prior computational-path formalization is disclosed in PROVENANCE.md. Its
source and proof terms are not reused here. The earlier based-group
formalization in Isabelle/HOL is also disclosed and is not reused.

The statement, implementation, dependency provenance, and verification
evidence are available for maintainer and editorial review. This contribution
record does not claim mathematical novelty, independent expert review,
endorsement by source authors, Palomar acceptance, or registry status.
Preparing this repository does not itself authorize or perform a Palomar
intake or registration.
