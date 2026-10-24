# $NetBSD$

BUILDLINK_TREE+=	alembic

.if !defined(ALEMBIC_BUILDLINK3_MK)
ALEMBIC_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.alembic+=	alembic>=1.8.0
BUILDLINK_PKGSRCDIR.alembic?=	../../wip/alembic

.include "../../math/imath/buildlink3.mk"
.endif	# ALEMBIC_BUILDLINK3_MK

BUILDLINK_TREE+=	-alembic
