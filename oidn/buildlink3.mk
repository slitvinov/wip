# $NetBSD$

BUILDLINK_TREE+=	oidn

.if !defined(OIDN_BUILDLINK3_MK)
OIDN_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.oidn+=	oidn>=2.0.0
BUILDLINK_PKGSRCDIR.oidn?=	../../wip/oidn

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# OIDN_BUILDLINK3_MK

BUILDLINK_TREE+=	-oidn
