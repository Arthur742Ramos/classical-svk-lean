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
the open-cover pushout theorem. The proof uses continuous paths and
endpoint-preserving path homotopies. The indiscrete preorder makes every path
directed, and the package proves that the resulting path category is naturally
equivalent to Mathlib's path groupoid.

For the categorical universal property, compatible functors on the two open
pieces are extended to the whole space by subdividing each path into finitely
many pieces lying in one member of the cover. Refinements and reparametrizations
do not change the resulting composite, and subdividing a path homotopy into
small rectangles proves that homotopic paths have the same image. The selected
Lean proof assembles this descent functor and its uniqueness directly from
these path and homotopy constructions; it does not invoke the packaged
`DirectedVanKampen.directed_van_kampen` theorem. The interval and square
subdivision lemmas are adapted from the cited directed-topology formalization,
so this is not a claim of independent authorship of that helper infrastructure
or of a new topological theorem.

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

The formal path-cover and homotopy-grid infrastructure is adapted from Basold,
Bruin, and Lawson, “The Directed Van Kampen Theorem in Lean,” ITP 2024:
[paper and artifact](https://doi.org/10.4230/LIPIcs.ITP.2024.8). That project
formalizes directed path subdivision and homotopy arguments. This project
specializes the path condition to the universal preorder, proves the
comparison with Mathlib's ordinary path quotient, and constructs the target
pushout property from the constructive descent lemmas.

No novelty, priority, source-author endorsement, independent human proof
review, or Palomar editorial acceptance is claimed. Palomar editors remain
responsible for judging suitability.
