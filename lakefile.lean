import Lake
open Lake DSL

package classical_svk

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @
  "a6a17daf8c81a2c35aff2e43a431a7c591fa708a"

require lean_4 from git
  "https://github.com/Dominique-Lawson/Directed-Topology-Lean-4.git" @
  "009529606c66d37ef93b4b81b8587f71ce4d2c56"

@[default_target]
lean_lib Challenge

@[default_target]
lean_lib Solution
