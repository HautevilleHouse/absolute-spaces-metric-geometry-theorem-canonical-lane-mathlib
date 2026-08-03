import AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean.Basic

/-!
# Absolute Spaces Metric Geometry Theorem Package
-/

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

structure AbsoluteSpacesMetricGeometryTheoremPackage {α : Type u}
    {A : AbsoluteSpace α} {M : AbsoluteSpaceMetricPackage A}
    (C : MetricGeometryCanonicalPackage M) where
  ptolemyInequality : Prop
  metricIsEquivalentToEuclidean : Prop
  absoluteSpaceIsHyperbolic : Prop
  mainTheoremStatement : Prop

structure AbsoluteSpacesMetricGeometryTheoremEvidence {α : Type u}
    {A : AbsoluteSpace α} {M : AbsoluteSpaceMetricPackage A}
    {C : MetricGeometryCanonicalPackage M}
    (T : AbsoluteSpacesMetricGeometryTheoremPackage C) where
  ptolemyInequalityClosed : T.ptolemyInequality
  metricIsEquivalentToEuclideanClosed : T.metricIsEquivalentToEuclidean
  absoluteSpaceIsHyperbolicClosed : T.absoluteSpaceIsHyperbolic
  mainTheoremStatementClosed : T.mainTheoremStatement

def AbsoluteSpacesMetricGeometryTheoremClosed {α : Type u}
    {A : AbsoluteSpace α} {M : AbsoluteSpaceMetricPackage A}
    {C : MetricGeometryCanonicalPackage M}
    (T : AbsoluteSpacesMetricGeometryTheoremPackage C) : Prop :=
  T.ptolemyInequality ∧ T.metricIsEquivalentToEuclidean ∧
  T.absoluteSpaceIsHyperbolic ∧ T.mainTheoremStatement

theorem absolute_spaces_metric_geometry_closed_from_evidence
    {α : Type u} {A : AbsoluteSpace α}
    {M : AbsoluteSpaceMetricPackage A} {C : MetricGeometryCanonicalPackage M}
    (T : AbsoluteSpacesMetricGeometryTheoremPackage C)
    (E : AbsoluteSpacesMetricGeometryTheoremEvidence T) :
    AbsoluteSpacesMetricGeometryTheoremClosed T := by
  exact And.intro E.ptolemyInequalityClosed
    (And.intro E.metricIsEquivalentToEuclideanClosed
      (And.intro E.absoluteSpaceIsHyperbolicClosed
        E.mainTheoremStatementClosed))

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse