# $NetBSD$

BUILDLINK_TREE+=	py-drjit

.if !defined(PY_DRJIT_BUILDLINK3_MK)
PY_DRJIT_BUILDLINK3_MK:=

.include "../../lang/python/pyversion.mk"

BUILDLINK_API_DEPENDS.py-drjit+=	${PYPKGPREFIX}-drjit>=1.5.0
BUILDLINK_PKGSRCDIR.py-drjit?=		../../wip/py-drjit
.endif # PY_DRJIT_BUILDLINK3_MK

BUILDLINK_TREE+=	-py-drjit
