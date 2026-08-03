import AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean.TheoremStatement

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

structure AdmissibleClass where
  object : AbsoluteMetricSpaceAdmittedObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

def admittedClosure (A : AdmissibleClass) : Prop :=
  AbsoluteWitnessClosed A.object ∧ (A.endpointSatisfied ∨ A.remainderRecorded)

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse