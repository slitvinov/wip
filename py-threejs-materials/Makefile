# $NetBSD$

DISTNAME=	threejs_materials-1.2.5
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=t/threejs-materials/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/bernhard-42/threejs-materials
COMMENT=	PBR materials converted to Three.js MeshPhysicalMaterial JSON
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=80:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-Pillow>=12.2.0:../../graphics/py-Pillow
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-platformdirs>=4.9.6:../../misc/py-platformdirs
DEPENDS+=	${PYPKGPREFIX}-pygltflib>=1.16:../../wip/py-pygltflib
DEPENDS+=	${PYPKGPREFIX}-requests>=2.31.0:../../devel/py-requests

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
