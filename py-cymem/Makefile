# $NetBSD$

DISTNAME=	cymem-2.0.16
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=c/cymem/}

MAINTAINER=	kamelderouiche@yahoo.com
HOMEPAGE=	https://github.com/explosion/cymem
COMMENT=	Manage calls to calloc/free through Cython
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.1:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	c c++

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
