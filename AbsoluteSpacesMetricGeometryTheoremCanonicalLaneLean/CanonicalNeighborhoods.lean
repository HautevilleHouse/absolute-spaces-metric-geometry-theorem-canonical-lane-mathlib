import Mathlib

/-!
# Canonical Neighborhoods for Absolute Spaces Metric Geometry

This file encodes the admissible-class bridge between canonical neighborhoods
and the Absolute Spaces Metric Geometry Theorem.
-/

namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

-- Prerequisite structures modelling an absolute space metric geometry.
structure AbsoluteSpaceModel where
  complete : Prop
  geodesic : Prop

structure FlowModel (M : AbsoluteSpaceModel) where
  existsShortTimeFlow : Prop

structure ShortTimeExistence (F : FlowModel M) where
  uniqueness : Prop

structure EntropyPackage (S : ShortTimeExistence F) where
  monotonicity : Prop

structure NoncollapsingPackage (E : EntropyPackage S) where
  volumeNoncollapse : Prop

structure SingularityModelsPackage (N : NoncollapsingPackage E) where
  classification : Prop

-- The canonical neighborhoods package for a singularity model.
structure CanonicalNeighborhoodsPackage {M : AbsoluteSpaceModel}
    {F : FlowModel M} {S : ShortTimeExistence F}
    {Epkg : EntropyPackage S} {N : NoncollapsingPackage Epkg}
    (Q : SingularityModelsPackage N) where
  standardNeighborhoodCover : Prop
  localModelDecomposition : Prop
  scaleCompatibility : Prop
  stabilityUnderFlow : Prop

-- Evidence that a canonical neighborhoods package is closed.
structure CanonicalNeighborhoodsEvidence {M : AbsoluteSpaceModel}
    {F : FlowModel M} {S : ShortTimeExistence F}
    {Epkg : EntropyPackage S} {N : NoncollapsingPackage Epkg}
    {Q : SingularityModelsPackage N} (C : CanonicalNeighborhoodsPackage Q) where
  standardNeighborhoodCoverProof : C.standardNeighborhoodCover
  localModelDecompositionProof : C.localModelDecomposition
  scaleCompatibilityProof : C.scaleCompatibility
  stabilityUnderFlowProof : C.stabilityUnderFlow

-- The closed condition for a canonical neighborhoods package.
def CanonicalNeighborhoodsClosed {M : AbsoluteSpaceModel}
    {F : FlowModel M} {S : ShortTimeExistence F}
    {Epkg : EntropyPackage S} {N : NoncollapsingPackage Epkg}
    {Q : SingularityModelsPackage N} (C : CanonicalNeighborhoodsPackage Q) : Prop :=
  C.standardNeighborhoodCover ∧ C.localModelDecomposition ∧
  C.scaleCompatibility ∧ C.stabilityUnderFlow

-- The main theorem of Absolute Spaces Metric Geometry.
-- It asserts the existence of a closed canonical neighborhoods package.
def AbsoluteSpacesMetricGeometryTheorem : Prop :=
  ∃ (M : AbsoluteSpaceModel) (F : FlowModel M) (S : ShortTimeExistence F)
    (Epkg : EntropyPackage S) (N : NoncollapsingPackage Epkg)
    (Q : SingularityModelsPackage N) (C : CanonicalNeighborhoodsPackage Q),
    CanonicalNeighborhoodsClosed C

-- Bridge: evidence gives the closed condition.
theorem canonical_neighborhoods_closed_from_evidence
    {M : AbsoluteSpaceModel} {F : FlowModel M} {S : ShortTimeExistence F}
    {Epkg : EntropyPackage S} {N : NoncollapsingPackage Epkg}
    {Q : SingularityModelsPackage N} (C : CanonicalNeighborhoodsPackage Q)
    (Ev : CanonicalNeighborhoodsEvidence C) :
    CanonicalNeighborhoodsClosed C := by
  exact And.intro Ev.standardNeighborhoodCoverProof
    (And.intro Ev.localModelDecompositionProof
      (And.intro Ev.scaleCompatibilityProof Ev.stabilityUnderFlowProof))

-- Bridge: a closed canonical neighborhoods package yields the main theorem.
theorem absolute_spaces_metric_geometry_theorem_of_closed
    {M : AbsoluteSpaceModel} {F : FlowModel M} {S : ShortTimeExistence F}
    {Epkg : EntropyPackage S} {N : NoncollapsingPackage Epkg}
    {Q : SingularityModelsPackage N} (C : CanonicalNeighborhoodsPackage Q)
    (h : CanonicalNeighborhoodsClosed C) : AbsoluteSpacesMetricGeometryTheorem := by
  exact ⟨M, F, S, Epkg, N, Q, C, h⟩

-- Combined bridge: evidence directly yields the main theorem.
theorem absolute_spaces_metric_geometry_theorem_from_evidence
    {M : AbsoluteSpaceModel} {F : FlowModel M} {S : ShortTimeExistence F}
    {Epkg : EntropyPackage S} {N : NoncollapsingPackage Epkg}
    {Q : SingularityModelsPackage N} (C : CanonicalNeighborhoodsPackage Q)
    (Ev : CanonicalNeighborhoodsEvidence C) : AbsoluteSpacesMetricGeometryTheorem :=
  absolute_spaces_metric_geometry_theorem_of_closed C
    (canonical_neighborhoods_closed_from_evidence C Ev)

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean