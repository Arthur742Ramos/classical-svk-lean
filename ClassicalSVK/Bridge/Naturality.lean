import ClassicalSVK.Bridge.Categories

open CategoryTheory
open scoped unitInterval FundamentalCategory

universe u

namespace ClassicalSVK

section
variable {X Y : Type u} [TopologicalSpace X] [TopologicalSpace Y]
local instance : Preorder X := universalPreorder X
local instance : Preorder Y := universalPreorder Y
local instance : DirectedSpace X := DirectedSpace.Preorder X
local instance : DirectedSpace Y := DirectedSpace.Preorder Y
attribute [local instance] Path.Homotopic.setoid Dipath.Dihomotopic.setoid

lemma directedToClassical_naturality (f : dTopCat.of X ⟶ dTopCat.of Y) :
    (FundamentalCategory.fundamentalCategoryFunctor.map f).toFunctor ⋙
        directedToClassical (X := Y) =
        directedToClassical (X := X) ⋙
        (CategoryTheory.Grpd.forgetToCat.map
          (FundamentalGroupoid.fundamentalGroupoidFunctor.map
            (TopCat.ofHom f.toContinuousMap))).toFunctor := by
  refine CategoryTheory.Functor.ext ?_ ?_
  · intro x
    rfl
  · intro x y q
    simp only [Functor.comp_map, eqToHom_refl, Category.id_comp, Category.comp_id]
    change directedClassToPathClass (Dipath.Dihomotopic.Quotient.mapFn q f) =
      Path.Homotopic.Quotient.mapFn (directedClassToPathClass q) f.toContinuousMap
    refine Quotient.inductionOn q ?_
    intro p
    rfl

end
end ClassicalSVK
