import Mathlib.AlgebraicTopology.FundamentalGroupoid.Basic
import Mathlib.CategoryTheory.Limits.Shapes.Pullback.CommSq
import Mathlib.CategoryTheory.Limits.Shapes.Pullback.IsPullback.Basic

/-!
# Seifert--van Kampen for the classical fundamental groupoid

The selected result is the ordinary topological two-open-set theorem. Its
morphisms are continuous paths modulo endpoint-preserving homotopy, as in
Mathlib's `FundamentalGroupoid`.
-/

universe u v

noncomputable section

open CategoryTheory

namespace ClassicalSVK

/-- The fundamental groupoid of a union of two open sets is the pushout of the
fundamental groupoids of the open sets over their intersection. -/
def completeStatement : Prop :=
  ∀ {X : Type u} [TopologicalSpace X] (U V : Set X),
    IsOpen U → IsOpen V → U ∪ V = Set.univ →
    let i₁ : TopCat.of (U ∩ V : Set X) ⟶ TopCat.of U :=
      ⟨(fun x => (⟨x.1, x.2.1⟩ : U)),
        Continuous.subtype_mk continuous_subtype_val (fun x => x.2.1)⟩
    let i₂ : TopCat.of (U ∩ V : Set X) ⟶ TopCat.of V :=
      ⟨(fun x => (⟨x.1, x.2.2⟩ : V)),
        Continuous.subtype_mk continuous_subtype_val (fun x => x.2.2)⟩
    let j₁ : TopCat.of U ⟶ TopCat.of X := ⟨Subtype.val, continuous_subtype_val⟩
    let j₂ : TopCat.of V ⟶ TopCat.of X := ⟨Subtype.val, continuous_subtype_val⟩
    IsPushout
      (CategoryTheory.Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map i₁))
      (CategoryTheory.Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map i₂))
      (CategoryTheory.Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map j₁))
      (CategoryTheory.Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map j₂))

theorem seifert_van_kampen_groupoid : completeStatement := by
  sorry

end ClassicalSVK
