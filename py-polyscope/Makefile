# $NetBSD$

DISTNAME=	polyscope-2.6.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=p/polyscope/}

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://polyscope.run/
COMMENT=	Viewer and user interface for 3D data such as meshes and point clouds
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-scikit-build-core-[0-9]*:../../devel/py-scikit-build-core
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-typing-extensions-[0-9]*:../../devel/py-typing-extensions

# The sdist bundles the Polyscope C++ library and its dependencies
# (GLFW, glad, ImGui, glm, Eigen, nanobind, ...); they are built
# statically into the extension module.
USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++20
USE_TOOLS+=		cmake

WHEEL_ARGS+=	-C build-dir=${WRKSRC}/build
# Do not lower the deployment target below the running macOS.
WHEEL_ARGS+=	-C cmake.args=

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Darwin"
WHEEL_ARGS+=		-C cmake.define.CMAKE_SKIP_BUILD_RPATH=ON
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
.endif

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
