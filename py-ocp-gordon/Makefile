# $NetBSD$

DISTNAME=	ocp_gordon-0.3.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	cad python
MASTER_SITES=	${MASTER_SITE_PYPI:=o/ocp-gordon/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/gongfan99/ocp_gordon
COMMENT=	Gordon surface interpolation with B-splines for OCP
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=61.0:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools_scm-[0-9]*:../../devel/py-setuptools_scm
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel
# Upstream depends on the cadquery-ocp-proxy metapackage, which only
# selects cadquery-ocp or cadquery-ocp-novtk on PyPI; depend on the OCP
# bindings directly.
DEPENDS+=	${PYPKGPREFIX}-cadquery-ocp-novtk>=8.0:../../wip/py-cadquery-ocp-novtk
DEPENDS+=	${PYPKGPREFIX}-numpy>=2:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-scipy-[0-9]*:../../math/py-scipy

USE_LANGUAGES=	# none

# requires-python >= 3.11
PYTHON_VERSIONS_INCOMPATIBLE=	310

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
