import ClassicalSVK.Bridge.Naturality

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

lemma classicalToDirected_naturality (f : dTopCat.of X ⟶ dTopCat.of Y) :
    (CategoryTheory.Grpd.forgetToCat.map
        (FundamentalGroupoid.fundamentalGroupoidFunctor.map
          (TopCat.ofHom f.toContinuousMap))).toFunctor ⋙
      classicalToDirected (X := Y) =
      classicalToDirected (X := X) ⋙
        (FundamentalCategory.fundamentalCategoryFunctor.map f).toFunctor := by
  refine CategoryTheory.Functor.ext ?_ ?_
  · intro x
    rfl
  · intro x y q
    simp only [Functor.comp_map, eqToHom_refl, Category.id_comp, Category.comp_id]
    change pathClassToDirectedClass (Path.Homotopic.Quotient.mapFn q f.toContinuousMap) =
      Dipath.Dihomotopic.Quotient.mapFn (pathClassToDirectedClass q) f
    refine Quotient.inductionOn q ?_
    intro p
    change (⟦pathToDipath (p.map f.toContinuousMap.continuous)⟧ : Dipath.Dihomotopic.Quotient _ _) =
      ⟦(pathToDipath p).map f⟧
    have hp : pathToDipath (p.map f.toContinuousMap.continuous) = (pathToDipath p).map f := by
      apply Dipath.ext
      funext t
      rfl
    rw [hp]

end
end ClassicalSVK
