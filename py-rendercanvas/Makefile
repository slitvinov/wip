# $NetBSD$

DISTNAME=	rendercanvas-2.7.2
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=r/rendercanvas/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/pygfx/rendercanvas
COMMENT=	One canvas API, multiple GUI backends, for wgpu rendering
LICENSE=	2-clause-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-flit_core-[0-9]*:../../devel/py-flit_core
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
# The glfw backend (rendercanvas.glfw), used by ManimGL's window.
DEPENDS+=	${PYPKGPREFIX}-glfw>=1.9:../../wip/py-glfw

USE_LANGUAGES=	# none

PYTHON_VERSIONS_INCOMPATIBLE=	310 311 # py-numpy

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
