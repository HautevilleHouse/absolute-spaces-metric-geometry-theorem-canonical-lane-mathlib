import Mathlib.Topology.MetricSpace.Basic

/-!
# Absolute Spaces Metric Geometry Package
-/

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

/-- A package recording the principal data in the Absolute Spaces Metric Geometry Theorem.
 The admissible-class bridge connects the formal theorem to its canonical instances. -/
structure AbsoluteSpacesMetricGeometryPackage where
  metricStructure : Type u
  absoluteStructure : Type v
  /-- Bridge statement relating the admissible class of metric spaces to the absoluteness property. -/
  admissibleClassBridge : Prop
  /-- The main metric geometry theorem. -/
  metricGeometryTheorem : Prop
  /-- A completeness or closure condition needed in the canonical setting. -/
  canonicalCompleteness : Prop

/-- Evidence that all components of the package are established. -/
structure AbsoluteSpacesMetricGeometryEvidence (Pkg : AbsoluteSpacesMetricGeometryPackage) where
  admissibleClassBridge_closed : Pkg.admissibleClassBridge
  metricGeometryTheorem_closed : Pkg.metricGeometryTheorem
  canonicalCompleteness_closed : Pkg.canonicalCompleteness

/-- The theorem is closed for a given package when all three statements hold. -/
def AbsoluteSpacesMetricGeometryClosed (Pkg : AbsoluteSpacesMetricGeometryPackage) : Prop :=
  Pkg.admissibleClassBridge ∧ Pkg.metricGeometryTheorem ∧ Pkg.canonicalCompleteness

/-- Construct the closed theorem from supplied evidence. -/
theorem absolute_spaces_metric_geometry_closed_from_evidence
    (Pkg : AbsoluteSpacesMetricGeometryPackage)
    (E : AbsoluteSpacesMetricGeometryEvidence Pkg) :
    AbsoluteSpacesMetricGeometryClosed Pkg := by
  exact And.intro E.admissibleClassBridge_closed
    (And.intro E.metricGeometryTheorem_closed E.canonicalCompleteness_closed)

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse