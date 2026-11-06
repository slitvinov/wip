# $NetBSD$

BUILDLINK_TREE+=	openusd

.if !defined(OPENUSD_BUILDLINK3_MK)
OPENUSD_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.openusd+=	openusd>=26.08
BUILDLINK_PKGSRCDIR.openusd?=	../../wip/openusd

.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../wip/opensubdiv/buildlink3.mk"
.include "../../wip/materialx/buildlink3.mk"
.include "../../graphics/openimageio/buildlink3.mk"
.include "../../graphics/opencolorio/buildlink3.mk"
.include "../../graphics/ptex/buildlink3.mk"
.include "../../wip/openvdb/buildlink3.mk"
.include "../../wip/alembic/buildlink3.mk"
.include "../../geography/draco/buildlink3.mk"
.include "../../wip/embree/buildlink3.mk"
.endif	# OPENUSD_BUILDLINK3_MK

BUILDLINK_TREE+=	-openusd
