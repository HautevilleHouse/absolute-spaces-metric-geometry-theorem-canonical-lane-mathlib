import AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

def ConstrainedAbsoluteSpaceClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_absolute_space_endgame (A : AdmissibleClass) :
    ConstrainedAbsoluteSpaceClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse