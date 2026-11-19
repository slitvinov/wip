# $NetBSD$

DISTNAME=	srsly-2.5.6
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=s/srsly/}

MAINTAINER=	kamelderouiche@yahoo.com
HOMEPAGE=	https://github.com/explosion/srsly
COMMENT=	Modern high-performance serialization utilities for Python
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.1:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-catalogue>=2.0.3:../../wip/py-catalogue

USE_LANGUAGES=	c c++

PYTHON_VERSIONS_INCOMPATIBLE=	315

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
