# $NetBSD$

DISTNAME=	ocpsvg-0.7.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	cad python
MASTER_SITES=	${MASTER_SITE_PYPI:=o/ocpsvg/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/snoyer/ocpsvg
COMMENT=	SVG import and export for OCP (OpenCascade) shapes
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools_scm>=6.2:../../devel/py-setuptools_scm
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel
# Upstream depends on the cadquery-ocp-proxy metapackage, which only
# selects cadquery-ocp or cadquery-ocp-novtk on PyPI; depend on the OCP
# bindings directly.
DEPENDS+=	${PYPKGPREFIX}-cadquery-ocp-novtk>=8.0:../../wip/py-cadquery-ocp-novtk
DEPENDS+=	${PYPKGPREFIX}-svgelements>=1.9.1:../../wip/py-svgelements

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
