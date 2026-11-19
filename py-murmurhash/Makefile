# $NetBSD$

DISTNAME=	murmurhash-1.0.16
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=m/murmurhash/}

MAINTAINER=	lntl@disroot.org
HOMEPAGE=	https://github.com/explosion/murmurhash
COMMENT=	Cython bindings for MurmurHash
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.1:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	c c++

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
