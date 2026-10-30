# $NetBSD$

BUILDLINK_TREE+=	meshoptimizer

.if !defined(MESHOPTIMIZER_BUILDLINK3_MK)
MESHOPTIMIZER_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.meshoptimizer+=	meshoptimizer>=1.0
BUILDLINK_PKGSRCDIR.meshoptimizer?=	../../wip/meshoptimizer
.endif	# MESHOPTIMIZER_BUILDLINK3_MK

BUILDLINK_TREE+=	-meshoptimizer
