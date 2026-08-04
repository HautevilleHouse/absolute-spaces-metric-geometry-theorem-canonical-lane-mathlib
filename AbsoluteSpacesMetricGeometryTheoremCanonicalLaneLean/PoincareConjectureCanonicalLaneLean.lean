/-
All Rights Reserved - No License Granted

Copyright (c) 2026 HautevilleHouse. All rights reserved.

This repository is published for academic review, citation, priority, public
notice, and research-reference purposes only.

No license is granted to use, copy, reproduce, redistribute, modify, merge,
publish, distribute, sublicense, sell, fork, mirror, scrape, use for training or
fine-tuning, include in a dataset or benchmark, use to create, evaluate, or
benchmark a derivative system, incorporate into another system, or create
derivative works from this repository or any substantial portion of it without
prior written permission from the rights holder.

Viewing this repository on GitHub for academic review and citation is permitted
with all rights reserved by the rights holder.

Any discussion, review, comparison, implementation, derivative research use, or
public reference to this repository must cite the repository and preserve this
notice.

Unauthorized reproduction or redistribution of this repository, including public
GitHub forks containing the repository contents, constitutes copyright
infringement and may be subject to DMCA.
-/
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
  refine ⟨γ (1 / 2 : ℝ), ?_⟩
  have h0 : (0 : ℝ) ∈ Set.Icc 0 1 := by norm_num [Set.mem_Icc]
  have hhalf : (1 / 2 : ℝ) ∈ Set.Icc 0 1 := by norm_num [Set.mem_Icc]
  have h1 : (1 : ℝ) ∈ Set.Icc 0 1 := by norm_num [Set.mem_Icc]
  have hdist0half : dist (γ 0) (γ (1 / 2)) = dist (0 : ℝ) (1 / 2) := hγiso h0 hhalf
  have hdisthalf1 : dist (γ (1 / 2)) (γ 1) = dist (1 / 2 : ℝ) (1 : ℝ) := hγiso hhalf h1
  have hdist01 : dist (γ 0) (γ 1) = dist (0 : ℝ) (1 : ℝ) := hγiso h0 h1
  have hx_m : dist x (γ (1 / 2)) = dist (0 : ℝ) (1 / 2) := by
    simpa [hγ0] using hdist0half
  have hm_y : dist (γ (1 / 2)) y = dist (1 / 2 : ℝ) (1 : ℝ) := by
    simpa [hγ1] using hdisthalf1
  have hx_y : dist x y = dist (0 : ℝ) (1 : ℝ) := by
    simpa [hγ0, hγ1] using hdist01
  constructor
  · rw [hx_m, hm_y]
    norm_num
  · rw [hx_m, hx_y]
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