import Challenge

/-!
Audit the compiled body of the exact Comparator-selected statement. Candidate
source may contribute only theorem-valued compiler proof helpers; candidate
definitions containing mathematical data are rejected.
-/

open Lean Elab Command

private def isCandidateModule (moduleName : Name) : Bool :=
  ["Challenge"].any (fun modulePrefix => moduleName.toString.startsWith modulePrefix)

elab "#audit_closed_statement" : command => do
  let env ← getEnv
  let root := `ClassicalSVK.completeStatement
  match env.find? root with
  | some (.defnInfo info) =>
    unless info.type == .sort .zero do
      throwError "selected completeStatement must have the closed type Prop"
    let mut checkedProofs := 0
    for name in info.value.getUsedConstants do
      match env.getModuleIdxFor? name with
      | none => throwError "statement body dependency has no defining module: {name}"
      | some moduleIndex =>
        let definingModule := env.header.moduleNames[moduleIndex.toNat]!
        if isCandidateModule definingModule then
          let generatedProofName :=
            (name.toString.splitOn (root.toString ++ ".proof_")).length > 1
          unless definingModule == `Challenge && generatedProofName do
            throwError "reachable candidate-defined mathematical data: {name}"
          match env.find? name with
          | some (.thmInfo theoremInfo) =>
            for dependency in theoremInfo.type.getUsedConstants do
              match env.getModuleIdxFor? dependency with
              | some dependencyIndex =>
                let dependencyModule := env.header.moduleNames[dependencyIndex.toNat]!
                if isCandidateModule dependencyModule then
                  throwError "generated theorem type refers to candidate-defined data: {dependency}"
              | none => pure ()
            checkedProofs := checkedProofs + 1
          | _ => throwError "generated statement helper is not a theorem: {name}"
    logInfo m!"Closed statement body audit passed; checked {checkedProofs} generated proposition proofs and found no candidate-defined mathematical data."
  | _ => throwError "missing Comparator-selected closed statement"

#audit_closed_statement
