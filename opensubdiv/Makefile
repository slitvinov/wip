# $NetBSD$

DISTNAME=	OpenSubdiv-3.7.0
PKGNAME=	${DISTNAME:tl}
CATEGORIES=	multimedia
MASTER_SITES=	${MASTER_SITE_GITHUB:=PixarAnimationStudios/}
GITHUB_PROJECT=	OpenSubdiv
GITHUB_TAG=	v${PKGVERSION_NOREV:S/./_/g:tu}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://graphics.pixar.com/opensubdiv/docs/intro.html
COMMENT=	High performance subdivision surface for parallel architectures
LICENSE=	apache-2.0

USE_LANGUAGES=	c c++

# Useless and installs files by default into subdirs of $PREFIX/bin/
CMAKE_CONFIGURE_ARGS+=	-DNO_TUTORIALS:BOOL=ON

# TODO
CMAKE_CONFIGURE_ARGS+=	-DNO_OPENCL:BOOL=ON
CMAKE_CONFIGURE_ARGS+=	-DNO_CUDA:BOOL=ON
# GLFW is only used by the examples.
CMAKE_CONFIGURE_ARGS+=	-DNO_GLFW:BOOL=ON
CMAKE_CONFIGURE_ARGS+=	-DNO_EXAMPLES:BOOL=ON

.include "../../mk/bsd.prefs.mk"
.if ${OPSYS} == "Darwin"
# Install plain libraries instead of an OpenSubdiv.framework.  The Metal
# backend (kernels compiled at run time) is kept: Blender needs its headers.
CMAKE_CONFIGURE_ARGS+=	-DNO_MACOS_FRAMEWORK:BOOL=ON
.endif

TEST_TARGET=	test

.include "options.mk"

# Out-of-source build: the bfr directory has a limits.h that would shadow
# the system header when the build directory equals the source directory.
.include "../../devel/cmake/build.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
