# $NetBSD$

BUILDLINK_TREE+=	manifold

.if !defined(MANIFOLD_BUILDLINK3_MK)
MANIFOLD_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.manifold+=	manifold>=3.0
BUILDLINK_PKGSRCDIR.manifold?=		../../wip/manifold

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# MANIFOLD_BUILDLINK3_MK

BUILDLINK_TREE+=	-manifold
