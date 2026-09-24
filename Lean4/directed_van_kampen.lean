import Mathlib.CategoryTheory.CommSq
import Mathlib.CategoryTheory.Limits.Shapes.Pullback.IsPullback.Basic
import Lean4.path_descent_helpers
import Lean4.dihomotopy_cover
import Lean4.pushout_alternative
import Lean4.dihomotopy_to_path_dihomotopy
import Lean4.morphism_aux

/-
  This file contains the directed version of the Van Kampen Theorem.
  The statement is as follows:
  Let `X : dTopCat` and `X₁ X₂ : Set X` such that `X₁` and `X₂` are both open and `X₁ ∪ X₂ = X`.
  Let `i₁ : X₁ ∩ X₂ → X₁`, `i₂ : X₁ ∩ X₂ → X₂`, `j₁ : X₁ → X` and `j₂ : X₂ → X` be the inclusion maps in `dTopCat`.
  Then we have a pushout in `Cat`:
  dπₓ(X₁ ∩ X₂) ------ dπₘ i₁ -----> dπₓ(X₁)
       |                              |
       |                              |
       |                              |
     dπₘ i₂                         dπₘ j₁
       |                              |
       |                              |
       |                              |
    dπₓ(X₂) ------- dπₘ j₂ ------> dπₓ(X)

  The proof we give is constructive and is based on the proof given by
  Marco Grandis, Directed Homotopy Theory I, published in Cahiers de topologie et géométrie différentielle catégoriques, 44, no 4, pages 307-309, 2003.
-/

universe u v

open Set
open scoped unitInterval Classical FundamentalCategory

attribute [local instance] Dipath.Dihomotopic.setoid

noncomputable section

namespace DirectedVanKampen

open FundamentalCategory DiSubtype CategoryTheory

variable {X : dTopCat.{u}} {X₁ X₂ : Set X}
variable (hX : X₁ ∪ X₂ = Set.univ)
variable (X₁_open : IsOpen X₁) (X₂_open : IsOpen X₂)

-- We will use a shorthand notation for the 4 morphisms in dTop:
-- i₁ : X₁ ∩ X₂ ⟶ X₁
local notation "i₁" => dTopCat.DirectedSubsetHom $ Set.inter_subset_left
-- i₁ : X₁ ∩ X₂ ⟶ X₂
local notation "i₂" => dTopCat.DirectedSubsetHom $ Set.inter_subset_right
-- j₁ : X₁ ⟶ X
local notation "j₁" => dTopCat.DirectedSubtypeHom X₁
-- j₂ : X₂ ⟶ X
local notation "j₂" => dTopCat.DirectedSubtypeHom X₂

/--
  The Van Kampen Theorem: the fundamental category functor dπ induces a pushout in the category of categories.
-/
theorem directed_van_kampen (X₁_open : IsOpen X₁) (X₂_open : IsOpen X₂) (hX : X₁ ∪ X₂ = Set.univ) :
    IsPushout (dπₘ i₁) (dπₘ i₂) (dπₘ j₁) (dπₘ j₂) := by
  apply PushoutAlternative.isPushout_alternative
  · rw [←Functor.map_comp]
    rw [←Functor.map_comp]
    exact congr_arg dπₘ rfl
  intros C F₁ F₂ h_comm
  use (PushoutFunctor.Functor hX X₁_open X₂_open h_comm)
  constructor
  constructor
  · apply PushoutFunctor.functor_comp_left
  · apply PushoutFunctor.functor_comp_right
  · rintro F' ⟨h₁, h₂⟩
    exact PushoutFunctor.functor_uniq hX X₁_open X₂_open h_comm F' h₁ h₂

end DirectedVanKampen
