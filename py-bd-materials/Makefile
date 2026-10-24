# $NetBSD$

DISTNAME=	bd_materials-0.2.5
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	cad python
MASTER_SITES=	${MASTER_SITE_PYPI:=b/bd-materials/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/bernhard-42/bd_materials
COMMENT=	Engineering materials with finishes and PBR looks for build123d
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=81:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-threejs-materials>=1.2.3:../../wip/py-threejs-materials
# Upstream pins webcolors~=24.8.0; it only uses the name/hex/rgb
# conversion functions, which 24.11 and 25.10 did not change (only the
# supported Python versions changed).
DEPENDS+=	${PYPKGPREFIX}-webcolors>=24.8.0:../../www/py-webcolors

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
