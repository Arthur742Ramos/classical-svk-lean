import ClassicalSVK.Bridge.Iso

open CategoryTheory
open CategoryTheory.Limits
open scoped unitInterval FundamentalCategory

universe u

namespace ClassicalSVK

theorem classicalOpenCoverPushout
    {X : Type u} [TopologicalSpace X] (U V : Set X)
    (hU : IsOpen U) (hV : IsOpen V) (hUV : U ∪ V = Set.univ) :
    let i₁ : TopCat.of (U ∩ V : Set X) ⟶ TopCat.of U :=
      ⟨(fun x => (⟨x.1, x.2.1⟩ : U)),
        Continuous.subtype_mk continuous_subtype_val (fun x => x.2.1)⟩
    let i₂ : TopCat.of (U ∩ V : Set X) ⟶ TopCat.of V :=
      ⟨(fun x => (⟨x.1, x.2.2⟩ : V)),
        Continuous.subtype_mk continuous_subtype_val (fun x => x.2.2)⟩
    let j₁ : TopCat.of U ⟶ TopCat.of X := ⟨Subtype.val, continuous_subtype_val⟩
    let j₂ : TopCat.of V ⟶ TopCat.of X := ⟨Subtype.val, continuous_subtype_val⟩
    IsPushout
      (Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map i₁))
      (Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map i₂))
      (Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map j₁))
      (Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map j₂)) := by
  dsimp only
  letI : Preorder X := universalPreorder X
  letI : DirectedSpace X := DirectedSpace.Preorder X
  let i₁ : TopCat.of (U ∩ V : Set X) ⟶ TopCat.of U :=
    ⟨(fun x => (⟨x.1, x.2.1⟩ : U)),
      Continuous.subtype_mk continuous_subtype_val (fun x => x.2.1)⟩
  let i₂ : TopCat.of (U ∩ V : Set X) ⟶ TopCat.of V :=
    ⟨(fun x => (⟨x.1, x.2.2⟩ : V)),
      Continuous.subtype_mk continuous_subtype_val (fun x => x.2.2)⟩
  let j₁ : TopCat.of U ⟶ TopCat.of X := ⟨Subtype.val, continuous_subtype_val⟩
  let j₂ : TopCat.of V ⟶ TopCat.of X := ⟨Subtype.val, continuous_subtype_val⟩
  let dI0_1 : dTopCat.of (U ∩ V : Set X) ⟶ dTopCat.of (U : Set X) :=
    dTopCat.DirectedSubsetHom (X := dTopCat.of X) (Y₀ := U ∩ V) (Y₁ := U) (Set.inter_subset_left U V)
  let dI0_2 : dTopCat.of (U ∩ V : Set X) ⟶ dTopCat.of (V : Set X) :=
    dTopCat.DirectedSubsetHom (X := dTopCat.of X) (Y₀ := U ∩ V) (Y₁ := V) (Set.inter_subset_right U V)
  let dJ0_1 : dTopCat.of (U : Set X) ⟶ dTopCat.of X := dTopCat.DirectedSubtypeHom (X := dTopCat.of X) U
  let dJ0_2 : dTopCat.of (V : Set X) ⟶ dTopCat.of X := dTopCat.DirectedSubtypeHom (X := dTopCat.of X) V
  have hi₁ : i₁ = dI0_1.toContinuousMap := by
    ext x
    exact Subtype.ext rfl
  have hi₂ : i₂ = dI0_2.toContinuousMap := by
    ext x
    exact Subtype.ext rfl
  have hj₁ : j₁ = dJ0_1.toContinuousMap := by
    ext x
    rfl
  have hj₂ : j₂ = dJ0_2.toContinuousMap := by
    ext x
    rfl
  let dI₁ := FundamentalCategory.fundamentalCategoryFunctor.map dI0_1
  let dI₂ := FundamentalCategory.fundamentalCategoryFunctor.map dI0_2
  let dJ₁ := FundamentalCategory.fundamentalCategoryFunctor.map dJ0_1
  let dJ₂ := FundamentalCategory.fundamentalCategoryFunctor.map dJ0_2
  let cI₁ := Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map i₁)
  let cI₂ := Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map i₂)
  let cJ₁ := Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map j₁)
  let cJ₂ := Grpd.forgetToCat.map (FundamentalGroupoid.fundamentalGroupoidFunctor.map j₂)
  let dToP_I : FundamentalCategory {x : X // x ∈ U ∩ V} ⥤ Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of {x : X // x ∈ U ∩ V})) := directedToClassical (X := {x : X // x ∈ U ∩ V})
  let dToP_U : FundamentalCategory U ⥤ Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of U)) := directedToClassical (X := U)
  let dToP_V : FundamentalCategory V ⥤ Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of V)) := directedToClassical (X := V)
  let dToP_X : FundamentalCategory X ⥤ Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of X)) := directedToClassical (X := X)
  let pToD_I : Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of {x : X // x ∈ U ∩ V})) ⥤ FundamentalCategory {x : X // x ∈ U ∩ V} := classicalToDirected (X := {x : X // x ∈ U ∩ V})
  let pToD_U : Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of U)) ⥤ FundamentalCategory U := classicalToDirected (X := U)
  let pToD_V : Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of V)) ⥤ FundamentalCategory V := classicalToDirected (X := V)
  let pToD_X : Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of X)) ⥤ FundamentalCategory X := classicalToDirected (X := X)
  have hi₁_nat : dI₁ ⋙ dToP_U = dToP_I ⋙ cI₁ := by
    dsimp [dI₁, dToP_U, dToP_I, cI₁]
    simpa only [← hi₁] using directedToClassical_naturality dI0_1
  have hi₂_nat : dI₂ ⋙ dToP_V = dToP_I ⋙ cI₂ := by
    dsimp [dI₂, dToP_V, dToP_I, cI₂]
    simpa only [← hi₂] using directedToClassical_naturality dI0_2
  have hj₁_nat : dJ₁ ⋙ dToP_X = dToP_U ⋙ cJ₁ := by
    dsimp [dJ₁, dToP_X, dToP_U, cJ₁]
    simpa only [← hj₁] using directedToClassical_naturality dJ0_1
  have hj₂_nat : dJ₂ ⋙ dToP_X = dToP_V ⋙ cJ₂ := by
    dsimp [dJ₂, dToP_X, dToP_V, cJ₂]
    simpa only [← hj₂] using directedToClassical_naturality dJ0_2
  have hi₁_nat' : cI₁ ⋙ pToD_U = pToD_I ⋙ dI₁ := by
    dsimp [dI₁, dToP_U, dToP_I, cI₁, pToD_U, pToD_I]
    simpa only [← hi₁] using classicalToDirected_naturality dI0_1
  have hi₂_nat' : cI₂ ⋙ pToD_V = pToD_I ⋙ dI₂ := by
    dsimp [dI₂, dToP_V, dToP_I, cI₂, pToD_V, pToD_I]
    simpa only [← hi₂] using classicalToDirected_naturality dI0_2
  have hj₁_nat' : cJ₁ ⋙ pToD_X = pToD_U ⋙ dJ₁ := by
    dsimp [dJ₁, dToP_X, dToP_U, cJ₁, pToD_X, pToD_U]
    simpa only [← hj₁] using classicalToDirected_naturality dJ0_1
  have hj₂_nat' : cJ₂ ⋙ pToD_X = pToD_V ⋙ dJ₂ := by
    dsimp [dJ₂, dToP_X, dToP_V, cJ₂, pToD_X, pToD_V]
    simpa only [← hj₂] using classicalToDirected_naturality dJ0_2
  have hIsoI : pToD_I ⋙ dToP_I = 𝟭 _ := by
    simpa [pToD_I, dToP_I, Grpd.forgetToCat, Cat.of] using
      (classicalToDirected_comp_directedToClassical (X := {x : X // x ∈ U ∩ V}))
  have hIsoU : pToD_U ⋙ dToP_U = 𝟭 _ := by
    simpa [pToD_U, dToP_U, Grpd.forgetToCat, Cat.of] using
      (classicalToDirected_comp_directedToClassical (X := U))
  have hIsoV : pToD_V ⋙ dToP_V = 𝟭 _ := by
    simpa [pToD_V, dToP_V, Grpd.forgetToCat, Cat.of] using
      (classicalToDirected_comp_directedToClassical (X := V))
  have hIsoX : pToD_X ⋙ dToP_X = 𝟭 _ := by
    simpa [pToD_X, dToP_X, Grpd.forgetToCat, Cat.of] using
      (classicalToDirected_comp_directedToClassical (X := X))
  have hdir : IsPushout dI₁ dI₂ dJ₁ dJ₂ := by
    simpa [dI₁, dI₂, dJ₁, dJ₂] using
      (DirectedVanKampen.directed_van_kampen (X := dTopCat.of X) (X₁ := U) (X₂ := V) (X₁_open := hU) (X₂_open := hV) (hX := hUV) hU hV)
  have hcomm : cI₁ ⋙ cJ₁ = cI₂ ⋙ cJ₂ := by
    calc
      cI₁ ⋙ cJ₁ = (pToD_I ⋙ dToP_I) ⋙ (cI₁ ⋙ cJ₁) := by
        rw [hIsoI]
        exact (Functor.id_comp (cI₁ ⋙ cJ₁)).symm
      _ = pToD_I ⋙ ((dToP_I ⋙ cI₁) ⋙ cJ₁) := by rfl
      _ = pToD_I ⋙ ((dI₁ ⋙ dToP_U) ⋙ cJ₁) := by rw [← hi₁_nat]
      _ = pToD_I ⋙ (dI₁ ⋙ (dToP_U ⋙ cJ₁)) := by rfl
      _ = pToD_I ⋙ (dI₁ ⋙ (dJ₁ ⋙ dToP_X)) := by rw [← hj₁_nat]
      _ = pToD_I ⋙ ((dI₁ ⋙ dJ₁) ⋙ dToP_X) := by rfl
      _ = pToD_I ⋙ ((dI₂ ⋙ dJ₂) ⋙ dToP_X) := by
        exact congrArg (fun f => pToD_I ⋙ f ⋙ dToP_X) hdir.w
      _ = pToD_I ⋙ (dI₂ ⋙ (dJ₂ ⋙ dToP_X)) := by rfl
      _ = pToD_I ⋙ (dI₂ ⋙ (dToP_V ⋙ cJ₂)) := by rw [hj₂_nat]
      _ = pToD_I ⋙ ((dI₂ ⋙ dToP_V) ⋙ cJ₂) := by rfl
      _ = pToD_I ⋙ ((dToP_I ⋙ cI₂) ⋙ cJ₂) := by rw [hi₂_nat]
      _ = (pToD_I ⋙ dToP_I) ⋙ (cI₂ ⋙ cJ₂) := by rfl
      _ = cI₂ ⋙ cJ₂ := by
        rw [hIsoI]
        exact Functor.id_comp (cI₂ ⋙ cJ₂)
  let cP : PushoutCocone cI₁ cI₂ := PushoutCocone.mk cJ₁ cJ₂ hcomm
  let toDirectedCocone : PushoutCocone cI₁ cI₂ → PushoutCocone dI₁ dI₂ := fun s =>
    PushoutCocone.mk (dToP_U ⋙ s.inl) (dToP_V ⋙ s.inr) (by
      calc
        dI₁ ⋙ (dToP_U ⋙ s.inl) = (dI₁ ⋙ dToP_U) ⋙ s.inl := by rfl
        _ = (dToP_I ⋙ cI₁) ⋙ s.inl := by rw [hi₁_nat]
        _ = dToP_I ⋙ (cI₁ ⋙ s.inl) := by rfl
        _ = dToP_I ⋙ (cI₂ ⋙ s.inr) := by exact congrArg (fun f => dToP_I ⋙ f) s.condition
        _ = (dToP_I ⋙ cI₂) ⋙ s.inr := by rfl
        _ = (dI₂ ⋙ dToP_V) ⋙ s.inr := by rw [← hi₂_nat]
        _ = dI₂ ⋙ (dToP_V ⋙ s.inr) := by rfl)
  let liftDesc : ∀ s : PushoutCocone cI₁ cI₂,
      Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of X)) ⟶ s.pt := fun s => by
    simpa only [toDirectedCocone] using
      (pToD_X ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr
        (toDirectedCocone s).condition)
  have hcolim : IsColimit cP := by
    change IsColimit (PushoutCocone.mk cJ₁ cJ₂ hcomm)
    refine PushoutCocone.IsColimit.mk (f := cI₁) (g := cI₂) (inl := cJ₁) (inr := cJ₂) hcomm liftDesc ?_ ?_ ?_
    · intro s
      change cJ₁ ⋙ (pToD_X ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition) = s.inl
      calc
        cJ₁ ⋙ (pToD_X ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition)
          = (cJ₁ ⋙ pToD_X) ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition := by rfl
        _ = (pToD_U ⋙ dJ₁) ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition := by rw [hj₁_nat']
        _ = pToD_U ⋙ (dJ₁ ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition) := by rfl
        _ = pToD_U ⋙ (dToP_U ⋙ s.inl) := by
          exact congrArg (fun f => pToD_U ⋙ f)
            (PushoutCocone.IsColimit.inl_desc hdir.isColimit (dToP_U ⋙ s.inl) (dToP_V ⋙ s.inr) (toDirectedCocone s).condition)
        _ = (pToD_U ⋙ dToP_U) ⋙ s.inl := by rfl
        _ = s.inl := by rw [hIsoU]; exact Functor.id_comp s.inl
    · intro s
      change cJ₂ ⋙ (pToD_X ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition) = s.inr
      calc
        cJ₂ ⋙ (pToD_X ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition)
          = (cJ₂ ⋙ pToD_X) ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition := by rfl
        _ = (pToD_V ⋙ dJ₂) ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition := by rw [hj₂_nat']
        _ = pToD_V ⋙ (dJ₂ ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition) := by rfl
        _ = pToD_V ⋙ (dToP_V ⋙ s.inr) := by
          exact congrArg (fun f => pToD_V ⋙ f)
            (PushoutCocone.IsColimit.inr_desc hdir.isColimit (dToP_U ⋙ s.inl) (dToP_V ⋙ s.inr) (toDirectedCocone s).condition)
        _ = (pToD_V ⋙ dToP_V) ⋙ s.inr := by rfl
        _ = s.inr := by rw [hIsoV]; exact Functor.id_comp s.inr
    · intro s m hm₁ hm₂
      have hmap : dToP_X ⋙ m = PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition := by
        let desc := PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition
        have hleft : dJ₁ ⋙ (dToP_X ⋙ m) = dJ₁ ⋙ desc := by
          calc
            dJ₁ ⋙ (dToP_X ⋙ m) = (dJ₁ ⋙ dToP_X) ⋙ m := by rfl
            _ = (dToP_U ⋙ cJ₁) ⋙ m := by rw [hj₁_nat]
            _ = dToP_U ⋙ (cJ₁ ⋙ m) := by rfl
            _ = dToP_U ⋙ s.inl := by
              change dToP_U ⋙ (cJ₁ ⋙ m) = dToP_U ⋙ s.inl
              change cJ₁ ⋙ m = s.inl at hm₁
              exact congrArg (fun f => dToP_U ⋙ f) hm₁
            _ = dJ₁ ⋙ desc := by
              exact (PushoutCocone.IsColimit.inl_desc hdir.isColimit (dToP_U ⋙ s.inl) (dToP_V ⋙ s.inr) (toDirectedCocone s).condition).symm
        have hright : dJ₂ ⋙ (dToP_X ⋙ m) = dJ₂ ⋙ desc := by
          calc
            dJ₂ ⋙ (dToP_X ⋙ m) = (dJ₂ ⋙ dToP_X) ⋙ m := by rfl
            _ = (dToP_V ⋙ cJ₂) ⋙ m := by rw [hj₂_nat]
            _ = dToP_V ⋙ (cJ₂ ⋙ m) := by rfl
            _ = dToP_V ⋙ s.inr := by
              change dToP_V ⋙ (cJ₂ ⋙ m) = dToP_V ⋙ s.inr
              change cJ₂ ⋙ m = s.inr at hm₂
              exact congrArg (fun f => dToP_V ⋙ f) hm₂
            _ = dJ₂ ⋙ desc := by
              exact (PushoutCocone.IsColimit.inr_desc hdir.isColimit (dToP_U ⋙ s.inl) (dToP_V ⋙ s.inr) (toDirectedCocone s).condition).symm
        exact PushoutCocone.IsColimit.hom_ext hdir.isColimit hleft hright
      calc
        m = (𝟙 (Grpd.forgetToCat.obj (FundamentalGroupoid.fundamentalGroupoidFunctor.obj (TopCat.of X)))) ⋙ m := by exact (Functor.id_comp m).symm
        _ = (pToD_X ⋙ dToP_X) ⋙ m := by rw [hIsoX]; exact (Category.id_comp m).trans (Functor.id_comp m).symm
        _ = pToD_X ⋙ (dToP_X ⋙ m) := by rfl
        _ = pToD_X ⋙ PushoutCocone.IsColimit.desc hdir.isColimit (toDirectedCocone s).inl (toDirectedCocone s).inr (toDirectedCocone s).condition := by rw [hmap]
  exact IsPushout.of_isColimit hcolim

end ClassicalSVK
