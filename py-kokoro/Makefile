# $NetBSD$

DISTNAME=	kokoro-0.9.4
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	audio python
MASTER_SITES=	${MASTER_SITE_PYPI:=k/kokoro/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/hexgrad/kokoro
COMMENT=	Inference library for the Kokoro-82M text-to-speech model
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-hatchling-[0-9]*:../../devel/py-hatchling
DEPENDS+=	${PYPKGPREFIX}-huggingface-hub-[0-9]*:../../wip/py-huggingface-hub
DEPENDS+=	${PYPKGPREFIX}-loguru-[0-9]*:../../sysutils/py-loguru
DEPENDS+=	${PYPKGPREFIX}-misaki>=0.9.4:../../wip/py-misaki
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-torch-[0-9]*:../../math/py-torch
DEPENDS+=	${PYPKGPREFIX}-transformers-[0-9]*:../../wip/py-transformers

USE_LANGUAGES=	# none

PY_RENAME_BINARIES=	kokoro

# Python 3.13 works, although pyproject.toml says <3.13.
PYTHON_VERSIONS_INCOMPATIBLE=	311 314 315	# py-torch

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
