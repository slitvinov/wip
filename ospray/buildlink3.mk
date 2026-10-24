# $NetBSD$

BUILDLINK_TREE+=	ospray

.if !defined(OSPRAY_BUILDLINK3_MK)
OSPRAY_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ospray+=	ospray>=3.2.0
BUILDLINK_PKGSRCDIR.ospray?=	../../wip/ospray

.include "../../wip/openvkl/buildlink3.mk"
.include "../../wip/embree/buildlink3.mk"
.include "../../wip/rkcommon/buildlink3.mk"
.include "../../wip/oidn/buildlink3.mk"
.endif	# OSPRAY_BUILDLINK3_MK

BUILDLINK_TREE+=	-ospray
