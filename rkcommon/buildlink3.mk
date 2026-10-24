# $NetBSD$

BUILDLINK_TREE+=	rkcommon

.if !defined(RKCOMMON_BUILDLINK3_MK)
RKCOMMON_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.rkcommon+=	rkcommon>=1.15.2
BUILDLINK_PKGSRCDIR.rkcommon?=		../../wip/rkcommon

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# RKCOMMON_BUILDLINK3_MK

BUILDLINK_TREE+=	-rkcommon
