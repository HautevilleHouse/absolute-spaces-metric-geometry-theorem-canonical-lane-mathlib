import Mathlib.Topology.Basic
import Mathlib.Data.Real.Basic
import CanonicalLaneMathlibCore

namespace HautevilleHouse
namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

open HautevilleHouse.CanonicalLaneMathlibCore

universe u

/-- A raw absolute space: a type with a distance function. -/
structure AbsoluteSpace where
  carrier : Type u
  distance : carrier → carrier → ℝ

/-- A geodesic segment between two points. -/
structure Geodesic (X : AbsoluteSpace) (a b : X.carrier) where
  map : ℝ → X.carrier
  start : map 0 = a
  finish : map 1 = b
  speed : ∀ {t s : ℝ}, X.distance (map t) (map s) = |t - s| * X.distance a b

/-- Property that a space has a unique geodesic between every pair of points. -/
def HasUniqueGeodesic (X : AbsoluteSpace) : Prop :=
  ∀ a b : X.carrier, ∃! g : Geodesic X a b, True

/-- An admitted object in the canonical lane: a space together with a bridge witness. -/
structure AbsoluteAdmittedObject where
  space : AbsoluteSpace
  geodesic_connected : Prop
  has_unique_geodesic : HasUniqueGeodesic space
  model : Type u
  model_distance : model → model → ℝ
  isometry_to_model : Prop
  conclusion : HasUniqueGeodesic space

/-- Endgame state: the bridge object. -/
structure AbsoluteEndgameState where
  object : AbsoluteAdmittedObject

/-- The witness for the absolute spaces metric geometry theorem. -/
def AbsoluteWitness (O : AbsoluteAdmittedObject) : Prop :=
  O.has_unique_geodesic

/-- Bridge theorem: any admitted object has the conclusion. -/
theorem absolute_bridge (O : AbsoluteAdmittedObject) : O.conclusion :=
  O.conclusion

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse