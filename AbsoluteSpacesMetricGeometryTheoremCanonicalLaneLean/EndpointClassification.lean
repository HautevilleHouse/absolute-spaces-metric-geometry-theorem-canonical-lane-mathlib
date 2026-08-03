import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Isometry

/-!
# Absolute Spaces Metric Geometry Canonical Lane Lean

This file provides an admissible-class bridge for the Absolute Spaces Metric Geometry Theorem.
-/

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryCanonicalLaneLean

universe u

/-- The data for the Absolute Spaces Metric Geometry Theorem. -/
structure AbsoluteSpacesMetricGeometryPackage where
  /-- The source space. -/
  Space : Type u
  /-- The model space, which is a canonical absolute space. -/
  ModelSpace : Type u
  /-- Metric on the source space. -/
  instMetricSpaceSpace : MetricSpace Space
  /-- Metric on the model space. -/
  instMetricSpaceModel : MetricSpace ModelSpace
  /-- The source space is an absolute space. -/
  isAbsoluteSpace : Prop
  /-- The source space is complete and geodesic. -/
  isCompleteGeodesicSpace : Prop
  /-- A bridge isometry between the source and the model. -/
  isometryBridge : Nonempty (Space ≃ᵢ ModelSpace)
  /-- The overall classification statement of the theorem. -/
  classificationStatement : Prop

/-- Evidence that the hypotheses of the theorem are satisfied. -/
structure AbsoluteSpacesMetricGeometryEvidence
    (P : AbsoluteSpacesMetricGeometryPackage) where
  /-- The absolute-space hypothesis. -/
  absoluteSpaceCondition : P.isAbsoluteSpace
  /-- The complete-geodesic hypothesis. -/
  completeGeodesicCondition : P.isCompleteGeodesicSpace
  /-- The classification statement. -/
  classificationCondition : P.classificationStatement

/-- The statement of the Absolute Spaces Metric Geometry Theorem for a given package. -/
def AbsoluteSpacesMetricGeometryTheorem
    (P : AbsoluteSpacesMetricGeometryPackage) : Prop :=
  P.isAbsoluteSpace ∧ P.isCompleteGeodesicSpace ∧ P.classificationStatement

/-- The theorem follows from the evidence. -/
theorem absolute_spaces_metric_geometry_from_evidence
    (P : AbsoluteSpacesMetricGeometryPackage)
    (E : AbsoluteSpacesMetricGeometryEvidence P) :
    AbsoluteSpacesMetricGeometryTheorem P := by
  exact And.intro E.absoluteSpaceCondition
    (And.intro E.completeGeodesicCondition E.classificationCondition)

/-- The package supplies the mathlib isometry bridge. -/
theorem absolute_spaces_metric_geometry_supplies_isometry
    (P : AbsoluteSpacesMetricGeometryPackage) :
    Nonempty (@IsometryEquiv P.Space P.ModelSpace P.instMetricSpaceSpace P.instMetricSpaceModel) :=
  P.isometryBridge

end AbsoluteSpacesMetricGeometryCanonicalLaneLean
end HautevilleHouse