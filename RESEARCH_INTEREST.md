# Research-interest case

## Exact mathematical statement

For every topological space X and every open cover X = U ∪ V, the
inclusion-induced square

    Π₁(U ∩ V)  →  Π₁(U)
         ↓             ↓
       Π₁(V)     →   Π₁(X)

is a pushout in Cat, where Π₁ is the groupoid of points and continuous paths
modulo endpoint-preserving homotopy. This is the full groupoid statement: it
does not choose one basepoint, require any of the four spaces to be path
connected, or assume that the intersection is connected.

## Why the groupoid formulation matters

The fundamental group at one basepoint records only loops there. When U ∩ V
has several path components, a single basepoint does not record how paths
between those components contribute to the glued space. The groupoid retains
all points as objects and all endpoint-pairs of path classes as morphisms.
Its pushout statement therefore gives a direct categorical gluing theorem
without selecting representatives of components.

Ronald Brown's primary paper introduced the groupoid form as a general
van Kampen theorem and explains why it is useful when the overlap is not
path-connected. The present proposition is the two-open-cover statement for
the full continuous-path groupoid, expressed with Mathlib's categorical
pushout API: [Brown, “Groupoids and Van Kampen's Theorem,” Theorem 3.4 and
§5](https://doi.org/10.1112/plms/s3-17.3.385). The paper's earlier
fundamental-group formulations lose information when the intersection has
multiple path components; the groupoid formulation preserves it.

## Formalization contribution and limits

Mathlib provides the ordinary fundamental groupoid but this package supplies
the open-cover pushout theorem. The proof links that API to the existing
formalized directed van Kampen theorem: the indiscrete preorder makes every
continuous path directed, and the package proves that the resulting directed
fundamental category is naturally equivalent to Mathlib's path groupoid.
This is a formal bridge and transfer of an established theorem, not a new
topological theorem and not an independent proof of the directed theorem.

The result is distinct in scope from the earlier computational-path SVK
formalization: that development proves based equivalences and presentation
theorems for its computational-path pushouts; this declaration concerns
actual open subsets of an arbitrary topological space and a pushout of the
ordinary continuous-path groupoids. No source code or proof is reused from
that project. It is also stronger in scope than a based theorem requiring a
path-connected intersection.

The reusable mathematical interface is the all-endpoint groupoid pushout.
It can support component-sensitive computations and future formalizations
that decompose spaces into open pieces. No application theorem is claimed in
this entry.

The proof dependency is the Lean formalization by Basold, Bruin, and Lawson,
“The Directed Van Kampen Theorem in Lean,” ITP 2024:
[paper and artifact](https://doi.org/10.4230/LIPIcs.ITP.2024.8). That paper
formalizes the directed fundamental-category theorem. This project specializes
its directedness structure to the universal preorder and translates the
result to Mathlib's ordinary fundamental groupoid.

No novelty, priority, source-author endorsement, independent human proof
review, or Palomar editorial acceptance is claimed. Palomar editors remain
responsible for judging suitability.
