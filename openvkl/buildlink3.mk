# $NetBSD$

BUILDLINK_TREE+=	openvkl

.if !defined(OPENVKL_BUILDLINK3_MK)
OPENVKL_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.openvkl+=	openvkl>=2.0.2
BUILDLINK_PKGSRCDIR.openvkl?=	../../wip/openvkl

.include "../../wip/embree/buildlink3.mk"
.include "../../wip/rkcommon/buildlink3.mk"
.endif	# OPENVKL_BUILDLINK3_MK

BUILDLINK_TREE+=	-openvkl
