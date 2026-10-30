# $NetBSD$

BUILDLINK_TREE+=	openpgl

.if !defined(OPENPGL_BUILDLINK3_MK)
OPENPGL_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.openpgl+=	openpgl>=0.7.0
BUILDLINK_PKGSRCDIR.openpgl?=	../../wip/openpgl

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# OPENPGL_BUILDLINK3_MK

BUILDLINK_TREE+=	-openpgl
