-- This module is the root of the AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean Lean proof package.
-- It encodes the admissible-class bridge for the key theorems and structures in absolute spaces metric geometry.

import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Isometry
import Mathlib.Analysis.Normed.Group.Basic
import Mathlib.Topology.Instances.Real
import Mathlib.Data.Real.Basic

open scoped Topology
open Set

namespace AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean

/-- A map is an isometry on a subset if it preserves distances there. -/
def IsometryOn {α β : Type*} [PseudoMetricSpace α] [PseudoMetricSpace β]
    (f : α → β) (s : Set α) : Prop :=
  ∀ ⦃x⦄, x ∈ s → ∀ ⦃y⦄, y ∈ s → dist (f x) (f y) = dist x y

/-- An absolute space is a complete metric space in which every two points can be joined by
a unit-speed geodesic segment. -/
class AbsoluteSpace (α : Type u) extends MetricSpace α where
  complete : CompleteSpace α
  geodesic : ∀ x y : α, ∃ γ : ℝ → α, γ 0 = x ∧ γ 1 = y ∧
    IsometryOn γ (Set.Icc (0 : ℝ) 1)

/-- In an absolute space, the midpoint of any two points exists. -/
theorem midpoint_exists (α : Type u) [AbsoluteSpace α] (x y : α) :
    ∃ m : α, dist x m = dist m y ∧ dist x m = dist x y / 2 := by
  rcases AbsoluteSpace.geodesic x y with ⟨γ, hγ0, hγ1, hγiso⟩
  let m : α := γ (1 / 2 : ℝ)
  refine ⟨m, ?_⟩
  have h0 : (0 : ℝ) ∈ Set.Icc 0 1 := by simp
  have hhalf : (1 / 2 : ℝ) ∈ Set.Icc 0 1 := by simp [Set.mem_Icc]
  have h1 : (1 : ℝ) ∈ Set.Icc 0 1 := by simp
  have hdist0half : dist (γ 0) (γ (1 / 2)) = dist (0 : ℝ) (1 / 2) := hγiso h0 hhalf
  have hdisthalf1 : dist (γ (1 / 2)) (γ 1) = dist (1 / 2 : ℝ) (1 : ℝ) := hγiso hhalf h1
  have hdist01 : dist (γ 0) (γ 1) = dist (0 : ℝ) (1 : ℝ) := hγiso h0 h1
  rw [hγ0, hγ1] at hdist0half hdisthalf1 hdist01
  constructor
  · -- dist x m = dist m y
    rw [← hdist0half, ← hdisthalf1]
    simp
  · -- dist x m = dist x y / 2
    rw [← hdist0half, ← hdist01]
    norm_num

/-- Noncomputably choose the midpoint. -/
noncomputable def midpoint (α : Type u) [AbsoluteSpace α] (x y : α) : α :=
  Classical.choose (midpoint_exists α x y)

/-- The midpoint lies at equal distance from both endpoints. -/
theorem midpoint_spec (α : Type u) [AbsoluteSpace α] (x y : α) :
    dist x (midpoint α x y) = dist (midpoint α x y) y ∧
      dist x (midpoint α x y) = dist x y / 2 :=
  Classical.choose_spec (midpoint_exists α x y)

/-- The admissible class for absolute spaces metric geometry: completeness plus midpoint existence. -/
def AdmissibleClass (α : Type u) [MetricSpace α] : Prop :=
  CompleteSpace α ∧ ∀ x y : α, ∃ m : α, dist x m = dist m y ∧ dist x m = dist x y / 2

/-- Every absolute space is admissible. -/
theorem absoluteSpace_is_admissible (α : Type u) [AbsoluteSpace α] : AdmissibleClass α :=
  ⟨AbsoluteSpace.complete, midpoint_exists α⟩

/-- The canonical lane for the absolute spaces metric geometry theorem. -/
structure CanonicalLane where
  space : Type u
  [absoluteSpace : AbsoluteSpace space]

/-- The fundamental bridge: any absolute space gives rise to a canonical lane. -/
def canonicalLane_of_absoluteSpace (α : Type u) [AbsoluteSpace α] : CanonicalLane :=
  ⟨α, inferInstance⟩

/-- The metric geometry theorem for absolute spaces: every pair of points has a midpoint.
This is the central bridge statement of the canonical lane. -/
theorem absolute_spaces_metric_geometry_theorem (α : Type u) [AbsoluteSpace α] :
    ∃ m : α → α → α, ∀ x y, dist x (m x y) = dist (m x y) y ∧ dist x (m x y) = dist x y / 2 :=
  ⟨midpoint α, midpoint_spec α⟩

end AbsoluteSpacesMetricGeometryTheoremCanonicalLaneLean