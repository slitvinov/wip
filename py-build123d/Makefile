# $NetBSD$

DISTNAME=	build123d-0.13.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	cad python
MASTER_SITES=	${MASTER_SITE_PYPI:=b/build123d/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/gumyr/build123d
COMMENT=	Python parametric boundary representation (BREP) CAD library
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=45:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools_scm>=6.2:../../devel/py-setuptools_scm
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel
DEPENDS+=	${PYPKGPREFIX}-anytree>=2.8.0:../../devel/py-anytree
DEPENDS+=	${PYPKGPREFIX}-bd-materials>=0.2.0:../../wip/py-bd-materials
DEPENDS+=	${PYPKGPREFIX}-cadquery-ocp-novtk>=8.0<8.1:../../wip/py-cadquery-ocp-novtk
DEPENDS+=	${PYPKGPREFIX}-ezdxf>=1.1.0:../../wip/py-ezdxf
DEPENDS+=	${PYPKGPREFIX}-fonttools>=4.39.0:../../fonts/py-fonttools
DEPENDS+=	${PYPKGPREFIX}-ipython>=8.0.0:../../devel/py-ipython
DEPENDS+=	${PYPKGPREFIX}-lib3mf>=2.4.1:../../wip/py-lib3mf
DEPENDS+=	${PYPKGPREFIX}-numpy>=2:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-ocp-gordon>=0.3.1:../../wip/py-ocp-gordon
DEPENDS+=	${PYPKGPREFIX}-ocpsvg>=0.7:../../wip/py-ocpsvg
DEPENDS+=	${PYPKGPREFIX}-requests>=2.32:../../devel/py-requests
DEPENDS+=	${PYPKGPREFIX}-scikit-learn>=1.5:../../math/py-scikit-learn
DEPENDS+=	${PYPKGPREFIX}-scipy-[0-9]*:../../math/py-scipy
DEPENDS+=	${PYPKGPREFIX}-svgpathtools>=1.5.1:../../wip/py-svgpathtools
DEPENDS+=	${PYPKGPREFIX}-sympy-[0-9]*:../../math/py-sympy
DEPENDS+=	${PYPKGPREFIX}-threejs-materials>=1.2.1:../../wip/py-threejs-materials
DEPENDS+=	${PYPKGPREFIX}-trianglesolver-[0-9]*:../../wip/py-trianglesolver
DEPENDS+=	${PYPKGPREFIX}-typing-extensions>=4.16.0:../../devel/py-typing-extensions
# Upstream pins webcolors~=24.8.0; build123d only uses rgb_to_name,
# name_to_rgb and hex_to_rgb, unchanged in 24.11 and 25.10 (which only
# changed the supported Python versions).
DEPENDS+=	${PYPKGPREFIX}-webcolors>=24.8.0:../../www/py-webcolors

USE_LANGUAGES=	# none

# requires-python >= 3.11
PYTHON_VERSIONS_INCOMPATIBLE=	310

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
