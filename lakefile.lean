import Lake
open Lake DSL

package classical_svk

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @
  "065356127b1dc0016f66b7283ce0ce2c4055aa55"

@[default_target]
lean_lib Challenge
@[default_target]
lean_lib Solution
@[default_target]
lean_lib ClassicalSVK
@[default_target]
lean_lib Lean4
