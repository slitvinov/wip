# $NetBSD$

DISTNAME=	av-19.0.2
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	multimedia python
MASTER_SITES=	${MASTER_SITE_PYPI:=a/av/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://pyav.basswood.io/
COMMENT=	Pythonic bindings for the FFmpeg libraries
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.3.0:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=78.0:../../devel/py-setuptools
# Frame.to_ndarray()/from_ndarray(), used by ManimGL's VideoMobject.
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy

USE_TOOLS+=	pkg-config

PY_RENAME_BINARIES=	pyav

PYTHON_VERSIONS_INCOMPATIBLE=	310 311 # requires-python >= 3.12

# PyAV 19 needs FFmpeg 8 (it uses AV_FRAME_DATA_EXIF and other FFmpeg 8
# API), so it cannot use ffmpeg7.
.include "../../multimedia/ffmpeg8/buildlink3.mk"
.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
