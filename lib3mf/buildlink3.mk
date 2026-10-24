# $NetBSD$

BUILDLINK_TREE+=	lib3mf

.if !defined(LIB3MF_BUILDLINK3_MK)
LIB3MF_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.lib3mf+=	lib3mf>=2.5.0
BUILDLINK_PKGSRCDIR.lib3mf?=	../../wip/lib3mf

.include "../../archivers/libzip/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.endif	# LIB3MF_BUILDLINK3_MK

BUILDLINK_TREE+=	-lib3mf
