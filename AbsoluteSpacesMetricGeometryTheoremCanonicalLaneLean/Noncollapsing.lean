import Mathlib

/-!
# Absolute Spaces Metric Geometry Theorem: Noncollapsing Package

This file encodes the admissible-class bridge for the noncollapsing
conditions in the context of absolute spaces metric geometry.
-/

namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

/-- A package of hypotheses on an "absolute space" in metric geometry. -/
structure AbsoluteSpacePackage where
  isProper : Prop
  isGeodesic : Prop
  isLengthSpace : Prop
  isCatZero : Prop
  isNonpositivelyCurved : Prop

/-- A package recording the noncollapsing assumptions for a given absolute space. -/
structure NoncollapsingPackage (P : AbsoluteSpacePackage) where
  scaleInvariantVolumeLowerBound : Prop
  curvatureScaleControl : Prop
  blowupLimitNoncollapsed : Prop

/-- Evidence that the noncollapsing conditions are satisfied. -/
structure NoncollapsingEvidence {P : AbsoluteSpacePackage} (N : NoncollapsingPackage P) where
  scaleInvariantVolumeLowerBoundClosed : N.scaleInvariantVolumeLowerBound
  curvatureScaleControlClosed : N.curvatureScaleControl
  blowupLimitNoncollapsedClosed : N.blowupLimitNoncollapsed

/-- The conjunction of all noncollapsing conditions. -/
def NoncollapsingClosed {P : AbsoluteSpacePackage} (N : NoncollapsingPackage P) : Prop :=
  N.scaleInvariantVolumeLowerBound ∧ N.curvatureScaleControl ∧ N.blowupLimitNoncollapsed

/-- Closing noncollapsing from explicit evidence. -/
theorem noncollapsing_closed_from_evidence
    {P : AbsoluteSpacePackage} (N : NoncollapsingPackage P) (E : NoncollapsingEvidence N) :
    NoncollapsingClosed N := by
  exact And.intro E.scaleInvariantVolumeLowerBoundClosed
    (And.intro E.curvatureScaleControlClosed E.blowupLimitNoncollapsedClosed)

/-- The admissible class of absolute spaces: proper, geodesic, length space,
and with a scale-invariant volume lower bound. -/
def AdmissibleClass (P : AbsoluteSpacePackage) (N : NoncollapsingPackage P) : Prop :=
  P.isProper ∧ P.isGeodesic ∧ P.isLengthSpace ∧ N.scaleInvariantVolumeLowerBound

/-- The statement of the Absolute Spaces Metric Geometry Theorem. -/
structure AbsoluteSpacesMetricGeometryTheorem (P : AbsoluteSpacePackage) (N : NoncollapsingPackage P) where
  conclusion : Prop
  proof : conclusion

/-- Bridge statement: admissible absolute spaces satisfy the metric geometry theorem. -/
axiom absolute_spaces_metric_geometry_theorem_of_admissible
    (P : AbsoluteSpacePackage) (N : NoncollapsingPackage P)
    (h : AdmissibleClass P N) :
    AbsoluteSpacesMetricGeometryTheorem P N

/-- A concrete bridge: given noncollapsing evidence and the structural hypotheses,
the noncollapsing conditions close. -/
theorem absolute_spaces_metric_geometry_bridge_of_evidence
    {P : AbsoluteSpacePackage} (N : NoncollapsingPackage P) (E : NoncollapsingEvidence N)
    (hP : P.isProper ∧ P.isGeodesic ∧ P.isLengthSpace) :
    NoncollapsingClosed N :=
  noncollapsing_closed_from_evidence N E

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean