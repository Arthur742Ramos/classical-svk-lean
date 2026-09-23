# Vendored directed-topology source

This module tree is derived from
<https://github.com/Dominique-Lawson/Directed-Topology-Lean-4> at commit
`009529606c66d37ef93b4b81b8587f71ce4d2c56`, under the upstream `Lean4/`
directory (with the upstream root module `Lean4.lean`). The upstream MIT
license is preserved in [LICENSE.md](LICENSE.md), and the source README is
preserved in [README.md](README.md). `vendor-manifest.json` records the SHA-256
of each copied Lean source file both at that commit and in this port.

The port updates old Lean 4.6 / Mathlib APIs for Lean 4.28 and Mathlib commit
`8f9d9cff6bd728b17a24e163c9402775d9e6a365`. The compatibility edits are in:

- `Lean4/cover_lemma.lean`
- `Lean4/dihomotopy_cover.lean`
- `Lean4/dipath_subtype.lean`
- `Lean4/dipath.lean`
- `Lean4/directed_homotopy.lean`
- `Lean4/directed_path_homotopy.lean`
- `Lean4/directed_van_kampen.lean`
- `Lean4/dTop.lean`
- `Lean4/fraction_equalities.lean`
- `Lean4/fraction.lean`
- `Lean4/fundamental_category.lean`
- `Lean4/interpolate.lean`
- `Lean4/monotone_path.lean`
- `Lean4/path_cover.lean`
- `Lean4/pushout_alternative.lean`
- `Lean4/trans_refl.lean`
- `Lean4/unit_interval_aux.lean`
- `Lean4/SplitPath/split_dipath.lean`
- `Lean4/SplitPath/split_path.lean`
- `Lean4/SplitPath/split_properties.lean`

These changes adapt the source to current Lean and Mathlib declarations. The
mathematical directed van Kampen result used here remains the theorem in
`Lean4/directed_van_kampen.lean`; it is an explicit inherited dependency. The
new result is the equivalence between that directed category for the
indiscrete preorder and Mathlib's ordinary continuous-path groupoid, together
with its naturality and the transfer of the pushout. This is not an
independent proof of the directed theorem.
