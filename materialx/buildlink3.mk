# $NetBSD$

BUILDLINK_TREE+=	materialx

.if !defined(MATERIALX_BUILDLINK3_MK)
MATERIALX_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.materialx+=	materialx>=1.39.5
BUILDLINK_PKGSRCDIR.materialx?=		../../wip/materialx

.include "../../graphics/openimageio/buildlink3.mk"
.endif	# MATERIALX_BUILDLINK3_MK

BUILDLINK_TREE+=	-materialx
