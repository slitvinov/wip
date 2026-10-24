# $NetBSD$

BUILDLINK_TREE+=	embree

.if !defined(EMBREE_BUILDLINK3_MK)
EMBREE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.embree+=	embree>=4.0.0
BUILDLINK_PKGSRCDIR.embree?=	../../wip/embree

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# EMBREE_BUILDLINK3_MK

BUILDLINK_TREE+=	-embree
