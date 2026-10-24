# $NetBSD$

BUILDLINK_TREE+=	opensubdiv

.if !defined(OPENSUBDIV_BUILDLINK3_MK)
OPENSUBDIV_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.opensubdiv+=	opensubdiv>=3.6.0
BUILDLINK_PKGSRCDIR.opensubdiv?=	../../wip/opensubdiv

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# OPENSUBDIV_BUILDLINK3_MK

BUILDLINK_TREE+=	-opensubdiv
