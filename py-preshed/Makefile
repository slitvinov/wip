# $NetBSD$

DISTNAME=	preshed-3.0.15
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=p/preshed/}

MAINTAINER=	lntl@disroot.org
HOMEPAGE=	https://github.com/explosion/preshed
COMMENT=	Cython hash table mapping
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.1:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-cymem>=2.0.2:../../wip/py-cymem
DEPENDS+=	${PYPKGPREFIX}-murmurhash>=0.28.0:../../wip/py-murmurhash

USE_LANGUAGES=	c c++

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
