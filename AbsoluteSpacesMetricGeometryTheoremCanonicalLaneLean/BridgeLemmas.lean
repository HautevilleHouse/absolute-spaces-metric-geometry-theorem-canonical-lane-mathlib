import AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

def bridgeClosed (A : AdmissibleClass) : Prop :=
  AbsoluteWitnessClosed A.object

theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact A.object.conclusion

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse