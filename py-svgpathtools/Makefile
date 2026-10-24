# $NetBSD$

DISTNAME=	svgpathtools-1.8.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=s/svgpathtools/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/mathandy/svgpathtools
COMMENT=	Tools for manipulating and analyzing SVG paths and Bezier curves
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-scipy-[0-9]*:../../math/py-scipy
DEPENDS+=	${PYPKGPREFIX}-svgwrite-[0-9]*:../../wip/py-svgwrite

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
