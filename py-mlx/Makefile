# $NetBSD$

DISTNAME=	mlx-0.32.4
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	math python
MASTER_SITES=	${MASTER_SITE_GITHUB:=ml-explore/}
GITHUB_TAG=	v${PKGVERSION_NOREV}
WRKSRC=		${WRKDIR}/${DISTNAME}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/ml-explore/mlx
COMMENT=	Python bindings for MLX, an array framework for Apple silicon
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools>=80:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-typing-extensions-[0-9]*:../../devel/py-typing-extensions

# Same platform restriction as wip/mlx.
ONLY_FOR_PLATFORM=	Darwin-*-aarch64

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++20
USE_TOOLS+=		cmake

# Release version string (setup.py otherwise appends a date and git hash).
MAKE_ENV+=	PYPI_RELEASE=1

# setup.py's CMake build would compile the whole C++ library again and
# install it inside the Python package.  Build only the extension instead,
# from files/CMakeLists.txt, linked against wip/mlx.
SUBST_CLASSES+=		cmakedir
SUBST_STAGE.cmakedir=	pre-configure
SUBST_MESSAGE.cmakedir=	Building only the extension module.
SUBST_FILES.cmakedir=	setup.py
SUBST_SED.cmakedir=	-e 's|CMakeExtension("mlx.core")|CMakeExtension("mlx.core", "pkgsrc-cmake")|'

# setup.py adds these (space separated) arguments to its cmake call.
CMAKE_ARGS_ENV=		-DCMAKE_PREFIX_PATH=${PREFIX}
CMAKE_ARGS_ENV+=	-Dnanobind_DIR=${PREFIX}/${PYSITELIB}/nanobind/cmake
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_ARGS_ENV+=	-DCMAKE_SKIP_BUILD_RPATH=ON
MAKE_ENV+=		CMAKE_ARGS=${CMAKE_ARGS_ENV:Q}

LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names

post-extract:
	${MKDIR} ${WRKSRC}/pkgsrc-cmake
	${CP} ${FILESDIR}/CMakeLists.txt ${WRKSRC}/pkgsrc-cmake/

.include "../../lang/python/wheel.mk"
# After wheel.mk: py-nanobind's buildlink3.mk would otherwise make Python
# a build-only dependency.  MLX 0.32.4 pins nanobind 3.1.0.
BUILDLINK_API_DEPENDS.py-nanobind+=	${PYPKGPREFIX}-nanobind>=3.1.0
.include "../../devel/py-nanobind/buildlink3.mk"
.include "../../wip/mlx/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
