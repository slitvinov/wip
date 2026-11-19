# $NetBSD$

DISTNAME=	blis-1.3.4
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	math python
MASTER_SITES=	${MASTER_SITE_PYPI:=b/blis/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/explosion/cython-blis
COMMENT=	Fast matrix multiplication as a self-contained Python library
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.1:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	c c++

# setup.py builds the bundled BLIS kernels with ${BLIS_COMPILER} or ${CC}.
MAKE_ENV+=	BLIS_COMPILER=${CC:Q}

.include "../../math/py-numpy/buildlink3.mk"
.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
