import AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean.AbsoluteSpacesAnalyticProof

/-!
# Perelman Analytic Evidence Terms for Absolute Spaces Metric Geometry

This module exposes the proof terms carried by each analytic certificate in the
Absolute Spaces Metric Geometry Theorem route. The evidence terms project into
the theorem's closure, providing a term-level bridge from analytic inputs to the
final geometric statement.
-/

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

structure AbsoluteCurvatureEvidenceTerms {G : AbsoluteCurvaturePackage}
    (C : AbsoluteCurvatureCertificate G) where
  metricCurvatureBounds : C.metricCurvatureBounds
  comparisonGeometrySatisfied : C.comparisonGeometrySatisfied
  angleMonotonicity : C.angleMonotonicity
  hingeTheorem : C.hingeTheorem
  curvatureInputs : C.curvatureInputs
  curvatureClosed : AbsoluteCurvatureClosed G

def AbsoluteCurvatureCertificate.evidenceTerms {G : AbsoluteCurvaturePackage}
    (C : AbsoluteCurvatureCertificate G) : AbsoluteCurvatureEvidenceTerms C :=
  {
    metricCurvatureBounds := C.metricCurvatureBoundsClosed
    comparisonGeometrySatisfied := C.comparisonGeometrySatisfiedClosed
    angleMonotonicity := C.angleMonotonicityClosed
    hingeTheorem := C.hingeTheoremClosed
    curvatureInputs := C.curvatureInputsClosed
    curvatureClosed := absolute_curvature_closed_from_evidence G C.curvatureEvidence
  }

structure AbsoluteRenormalizationEvidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} (H : AbsoluteRenormalizationCertificate F) where
  gaugeChoice : H.gaugeChoice
  renormalizedFlowReduction : H.renormalizedFlowReduction
  scaleInvariance : H.scaleInvariance
  pullbackRecoversFlow : H.pullbackRecoversFlow
  uniquenessCompatibility : H.uniquenessCompatibility
  flowClosed : AbsoluteFlowClosed F

def AbsoluteRenormalizationCertificate.evidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} (H : AbsoluteRenormalizationCertificate F) :
    AbsoluteRenormalizationEvidenceTerms H :=
  {
    gaugeChoice := H.gaugeChoiceClosed
    renormalizedFlowReduction := H.renormalizedFlowReductionClosed
    scaleInvariance := H.scaleInvarianceClosed
    pullbackRecoversFlow := H.pullbackRecoversFlowClosed
    uniquenessCompatibility := H.uniquenessCompatibilityClosed
    flowClosed := absolute_flow_closed_from_evidence F H.flowEvidence
  }

structure AbsoluteLocalExistenceEvidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} {S : AbsoluteLocalExistencePackage F}
    (C : AbsoluteLocalExistenceCertificate S) where
  geodesicRegularity : C.geodesicRegularity
  localExistenceInterval : C.localExistenceInterval
  uniquenessOnOverlap : C.uniquenessOnOverlap
  continuationCriterion : C.continuationCriterion
  localExistenceClosed : AbsoluteLocalExistenceClosed S

def AbsoluteLocalExistenceCertificate.evidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} {S : AbsoluteLocalExistencePackage F}
    (C : AbsoluteLocalExistenceCertificate S) : AbsoluteLocalExistenceEvidenceTerms C :=
  {
    geodesicRegularity := C.geodesicRegularityClosed
    localExistenceInterval := C.localExistenceIntervalClosed
    uniquenessOnOverlap := C.uniquenessOnOverlapClosed
    continuationCriterion := C.continuationCriterionClosed
    localExistenceClosed := absolute_local_existence_closed_from_evidence S C.localExistenceEvidence
  }

structure AbsoluteEntropyEvidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} {S : AbsoluteLocalExistencePackage F}
    {E : AbsoluteEntropyPackage S} (C : AbsoluteEntropyCertificate E) where
  entropyFunctional : C.entropyFunctional
  monotonicityFormula : C.monotonicityFormula
  volumeEntropyCompatibility : C.volumeEntropyCompatibility
  reducedVolumeMonotonicity : C.reducedVolumeMonotonicity
  entropyClosed : AbsoluteEntropyClosed E

def AbsoluteEntropyCertificate.evidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} {S : AbsoluteLocalExistencePackage F}
    {E : AbsoluteEntropyPackage S} (C : AbsoluteEntropyCertificate E) :
    AbsoluteEntropyEvidenceTerms C :=
  {
    entropyFunctional := C.entropyFunctionalClosed
    monotonicityFormula := C.monotonicityFormulaClosed
    volumeEntropyCompatibility := C.volumeEntropyCompatibilityClosed
    reducedVolumeMonotonicity := C.reducedVolumeMonotonicityClosed
    entropyClosed := absolute_entropy_closed_from_evidence E C.entropyEvidence
  }

structure AbsoluteNoncollapsingEvidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} {S : AbsoluteLocalExistencePackage F}
    {E : AbsoluteEntropyPackage S} {N : AbsoluteNoncollapsingPackage E}
    (C : AbsoluteNoncollapsingCertificate N) where
  noLocalCollapsing : C.noLocalCollapsing
  scaleInvariantVolumeLowerBound : C.scaleInvariantVolumeLowerBound
  curvatureScaleCompatibility : C.curvatureScaleCompatibility
  compactnessInput : C.compactnessInput
  noncollapsingClosed : AbsoluteNoncollapsingClosed N

def AbsoluteNoncollapsingCertificate.evidenceTerms {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G} {S : AbsoluteLocalExistencePackage F}
    {E : AbsoluteEntropyPackage S} {N : AbsoluteNoncollapsingPackage E}
    (C : AbsoluteNoncollapsingCertificate N) : AbsoluteNoncollapsingEvidenceTerms C :=
  {
    noLocalCollapsing := C.noLocalCollapsingClosed
    scaleInvariantVolumeLowerBound := C.scaleInvariantVolumeLowerBoundClosed
    curvatureScaleCompatibility := C.curvatureScaleCompatibilityClosed
    compactnessInput := C.compactnessInputClosed
    noncollapsingClosed := absolute_noncollapsing_closed_from_evidence N C.noncollapsingEvidence
  }

/-- The main bridge statement: any collection of analytic certificates for the
Absolute Spaces Metric Geometry Theorem yields the theorem's closure. -/
theorem absolute_spaces_metric_geometry_theorem
    {G : AbsoluteCurvaturePackage}
    {F : AbsoluteFlowPackage G}
    {S : AbsoluteLocalExistencePackage F}
    {E : AbsoluteEntropyPackage S}
    {N : AbsoluteNoncollapsingPackage E}
    (Ccurv : AbsoluteCurvatureCertificate G)
    (Cren : AbsoluteRenormalizationCertificate F)
    (Cloc : AbsoluteLocalExistenceCertificate S)
    (Cent : AbsoluteEntropyCertificate E)
    (Cnon : AbsoluteNoncollapsingCertificate N)
    (hcurv : (AbsoluteCurvatureCertificate.evidenceTerms Ccurv).curvatureClosed)
    (hren : (AbsoluteRenormalizationCertificate.evidenceTerms Cren).flowClosed)
    (hloc : (AbsoluteLocalExistenceCertificate.evidenceTerms Cloc).localExistenceClosed)
    (hent : (AbsoluteEntropyCertificate.evidenceTerms Cent).entropyClosed)
    (hnon : (AbsoluteNoncollapsingCertificate.evidenceTerms Cnon).noncollapsingClosed) :
    AbsoluteCurvatureClosed G ∧ AbsoluteFlowClosed F ∧
    AbsoluteLocalExistenceClosed S ∧ AbsoluteEntropyClosed E ∧
    AbsoluteNoncollapsingClosed N :=
  And.intro hcurv (And.intro hren (And.intro hloc (And.intro hent hnon)))

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse