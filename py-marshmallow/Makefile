# $NetBSD$

DISTNAME=	marshmallow-3.26.2
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=m/marshmallow/}

MAINTAINER=	kethzer.dr@gmail.com
HOMEPAGE=	https://github.com/marshmallow-code/marshmallow
COMMENT=	Library for converting complex datatypes
LICENSE=	mit

# pyproject.toml asks for flit_core<4; flit_core 4.x builds it fine.
TOOL_DEPENDS+=	${PYPKGPREFIX}-flit_core-[0-9]*:../../devel/py-flit_core
DEPENDS+=	${PYPKGPREFIX}-packaging>=17.0:../../devel/py-packaging

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
