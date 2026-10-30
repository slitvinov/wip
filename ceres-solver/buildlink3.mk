# $NetBSD$

BUILDLINK_TREE+=	ceres-solver

.if !defined(CERES_SOLVER_BUILDLINK3_MK)
CERES_SOLVER_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ceres-solver+=	ceres-solver>=2.2.0.20251205
BUILDLINK_PKGSRCDIR.ceres-solver?=	../../wip/ceres-solver

# Public headers and CeresConfig.cmake reference both.
.include "../../devel/abseil/buildlink3.mk"
.include "../../math/eigen3/buildlink3.mk"
.endif	# CERES_SOLVER_BUILDLINK3_MK

BUILDLINK_TREE+=	-ceres-solver
