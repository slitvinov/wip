# $NetBSD$

# The last release, 1.7.2 (2024-12), still renders with moderngl/OpenGL;
# master has since moved to wgpu (WebGPU), so package a master snapshot.
DISTNAME=	manim-${GITHUB_TAG}
PKGNAME=	${PYPKGPREFIX}-manimgl-1.7.2.20260909
CATEGORIES=	multimedia graphics python
MASTER_SITES=	${MASTER_SITE_GITHUB:=3b1b/}
GITHUB_PROJECT=	manim
GITHUB_TAG=	fafa083a4fb274bba9cabde0b6e2f50ba6da0622

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/3b1b/manim
COMMENT=	Animation engine for explanatory math videos (3Blue1Brown version)
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel
DEPENDS+=	${PYPKGPREFIX}-addict-[0-9]*:../../wip/py-addict
DEPENDS+=	${PYPKGPREFIX}-appdirs-[0-9]*:../../devel/py-appdirs
DEPENDS+=	${PYPKGPREFIX}-av-[0-9]*:../../wip/py-av
DEPENDS+=	${PYPKGPREFIX}-colour-[0-9]*:../../wip/py-colour
DEPENDS+=	${PYPKGPREFIX}-diskcache-[0-9]*:../../wip/py-diskcache
DEPENDS+=	${PYPKGPREFIX}-fonttools-[0-9]*:../../fonts/py-fonttools
DEPENDS+=	${PYPKGPREFIX}-glfw-[0-9]*:../../wip/py-glfw
DEPENDS+=	${PYPKGPREFIX}-ipython>=8.18.0:../../devel/py-ipython
DEPENDS+=	${PYPKGPREFIX}-isosurfaces-[0-9]*:../../wip/py-isosurfaces
DEPENDS+=	${PYPKGPREFIX}-manimpango>=0.6.0:../../wip/py-manimpango
DEPENDS+=	${PYPKGPREFIX}-matplotlib-[0-9]*:../../graphics/py-matplotlib
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-Pillow-[0-9]*:../../graphics/py-Pillow
DEPENDS+=	${PYPKGPREFIX}-pydub-[0-9]*:../../wip/py-pydub
DEPENDS+=	${PYPKGPREFIX}-pygments-[0-9]*:../../textproc/py-pygments
DEPENDS+=	${PYPKGPREFIX}-pyperclip-[0-9]*:../../x11/py-pyperclip
DEPENDS+=	${PYPKGPREFIX}-pywavefront-[0-9]*:../../wip/py-pywavefront
DEPENDS+=	${PYPKGPREFIX}-yaml-[0-9]*:../../textproc/py-yaml
DEPENDS+=	${PYPKGPREFIX}-rendercanvas-[0-9]*:../../wip/py-rendercanvas
DEPENDS+=	${PYPKGPREFIX}-rich-[0-9]*:../../comms/py-rich
DEPENDS+=	${PYPKGPREFIX}-scipy-[0-9]*:../../math/py-scipy
DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-skia-pathops-[0-9]*:../../wip/py-skia-pathops
DEPENDS+=	${PYPKGPREFIX}-svgelements>=1.8.1:../../wip/py-svgelements
DEPENDS+=	${PYPKGPREFIX}-sympy-[0-9]*:../../math/py-sympy
DEPENDS+=	${PYPKGPREFIX}-tqdm-[0-9]*:../../misc/py-tqdm
DEPENDS+=	${PYPKGPREFIX}-trimesh-[0-9]*:../../wip/py-trimesh
DEPENDS+=	${PYPKGPREFIX}-validators-[0-9]*:../../textproc/py-validators
DEPENDS+=	${PYPKGPREFIX}-wgpu-[0-9]*:../../wip/py-wgpu
# Scenes are written to video by piping frames into ffmpeg.
DEPENDS+=	ffmpeg7-[0-9]*:../../multimedia/ffmpeg7
# Tex/TexText run latex and dvisvgm; these are the LaTeX packages the
# default template (manimlib/tex_templates.yml) loads.
DEPENDS+=	tex-latex-bin-[0-9]*:../../print/tex-latex-bin
DEPENDS+=	dvisvgm-[0-9]*:../../converters/dvisvgm
DEPENDS+=	tex-amsfonts-[0-9]*:../../fonts/tex-amsfonts
DEPENDS+=	tex-amsmath-[0-9]*:../../print/tex-amsmath
DEPENDS+=	tex-babel-english-[0-9]*:../../print/tex-babel-english
DEPENDS+=	tex-calligra-[0-9]*:../../fonts/tex-calligra
DEPENDS+=	tex-fundus-calligra-[0-9]*:../../print/tex-fundus-calligra
DEPENDS+=	tex-doublestroke-[0-9]*:../../fonts/tex-doublestroke
DEPENDS+=	tex-jknapltx-[0-9]*:../../print/tex-jknapltx
DEPENDS+=	tex-microtype-[0-9]*:../../print/tex-microtype
DEPENDS+=	tex-physics-[0-9]*:../../math/tex-physics
DEPENDS+=	tex-psnfss-[0-9]*:../../fonts/tex-psnfss
DEPENDS+=	tex-ragged2e-[0-9]*:../../print/tex-ragged2e
DEPENDS+=	tex-relsize-[0-9]*:../../print/tex-relsize
DEPENDS+=	tex-rsfs-[0-9]*:../../fonts/tex-rsfs
DEPENDS+=	tex-setspace-[0-9]*:../../print/tex-setspace
DEPENDS+=	tex-tipa-[0-9]*:../../fonts/tex-tipa
DEPENDS+=	tex-wasysym-[0-9]*:../../fonts/tex-wasysym
DEPENDS+=	tex-xcolor-[0-9]*:../../print/tex-xcolor

USE_LANGUAGES=	# none

WHEEL_NAME=	manimgl-1.7.2

PY_RENAME_BINARIES=	manimgl manim-render

PYTHON_VERSIONS_INCOMPATIBLE=	310 # py-wgpu

.include "../../lang/python/pyversion.mk"
# audioop (used by pydub) left the standard library in Python 3.13.
.if ${PYTHON_VERSION} >= 313
DEPENDS+=	${PYPKGPREFIX}-audioop-lts-[0-9]*:../../audio/py-audioop-lts
.endif

# pkgsrc installs ffmpeg 7 with a version suffix.
SUBST_CLASSES+=		ffmpeg
SUBST_STAGE.ffmpeg=	pre-configure
SUBST_MESSAGE.ffmpeg=	Setting the path to ffmpeg7.
SUBST_FILES.ffmpeg=	manimlib/default_config.yml manimlib/scene/scene_file_writer.py
SUBST_SED.ffmpeg=	-e 's|ffmpeg_bin: "ffmpeg"|ffmpeg_bin: "${PREFIX}/bin/ffmpeg7"|'
SUBST_SED.ffmpeg+=	-e 's|ffmpeg_bin: str = "ffmpeg"|ffmpeg_bin: str = "${PREFIX}/bin/ffmpeg7"|'

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
