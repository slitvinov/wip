# $NetBSD$

DISTNAME=	trimesh-5.2.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	math python
MASTER_SITES=	${MASTER_SITE_PYPI:=t/trimesh/}

MAINTAINER=	jihbed.research@gmail.com
HOMEPAGE=	https://github.com/mikedh/trimesh
COMMENT=	Import, export, process, analyze and view triangular meshes
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=61.0:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-numpy>=1.21:../../math/py-numpy
# Optional ("easy" extra) modules that are in pkgsrc: scene graphs
# (networkx), proximity and convex hulls (scipy), and the textures of
# OBJ/GLTF meshes (Pillow).
DEPENDS+=	${PYPKGPREFIX}-networkx-[0-9]*:../../math/py-networkx
DEPENDS+=	${PYPKGPREFIX}-scipy-[0-9]*:../../math/py-scipy
DEPENDS+=	${PYPKGPREFIX}-Pillow-[0-9]*:../../graphics/py-Pillow

USE_LANGUAGES=	# none

PY_RENAME_BINARIES=	trimesh

PYTHON_VERSIONS_INCOMPATIBLE=	310 311 # py-numpy

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
