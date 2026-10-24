# $NetBSD$

DISTNAME=	glfw-2.11.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=g/glfw/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/FlorianRhiem/pyGLFW
COMMENT=	Python ctypes bindings for GLFW
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
# Only the shared library is needed: it is loaded with ctypes.
DEPENDS+=	glfw>=3.0:../../graphics/glfw

USE_LANGUAGES=	# none

.include "../../mk/bsd.prefs.mk"

# The bindings dlopen() the library at import time: point them at the
# pkgsrc GLFW (see patches/patch-glfw_library.py).
.if ${OPSYS} == "Darwin"
GLFW_LIBRARY=		${PREFIX}/lib/libglfw.3.dylib
.else
GLFW_LIBRARY=		${PREFIX}/lib/libglfw.so.3
.endif
SUBST_CLASSES+=		glfwlib
SUBST_STAGE.glfwlib=	pre-configure
SUBST_MESSAGE.glfwlib=	Setting the path to the GLFW library.
SUBST_FILES.glfwlib=	glfw/library.py
SUBST_VARS.glfwlib=	GLFW_LIBRARY

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
