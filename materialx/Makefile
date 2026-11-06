# $NetBSD$

DISTNAME=	MaterialX-1.39.5
PKGNAME=	${DISTNAME:tl}
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=AcademySoftwareFoundation/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://materialx.org/
COMMENT=	Open standard for the exchange of rich material and look-development
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_SHARED_LIBS=ON
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_PYTHON=ON
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_OIIO=ON
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_TESTS=OFF
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_USE_CCACHE=OFF
# The viewer and graph editor need NanoGUI/ImGui git submodules that are
# not part of the release tarball.
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_VIEWER=OFF
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_GRAPH_EDITOR=OFF
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_APPLE_FRAMEWORK=OFF
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_PYTHON_EXECUTABLE=${PYTHONBIN}
# Do not run pip at install time; install the Python package directly.
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_INSTALL_PYTHON=OFF
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_PYTHON_FOLDER_NAME=${PYSITELIB}/MaterialX
# FHS-like layout instead of top-level libraries/ and resources/.
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_INSTALL_INCLUDE_PATH=include
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_INSTALL_STDLIB_PATH=share/MaterialX/libraries
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_INSTALL_RESOURCES=OFF

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Darwin"
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_INSTALL_NAME_DIR=${PREFIX}/lib
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
.endif

# Let the C++ library find its data library in share/MaterialX.
SUBST_CLASSES+=		datadir
SUBST_STAGE.datadir=	pre-configure
SUBST_MESSAGE.datadir=	Setting the default data library path.
SUBST_FILES.datadir=	source/MaterialXFormat/Util.cpp
SUBST_VARS.datadir=	PREFIX

PY_PATCHPLIST=		yes
REPLACE_PYTHON+=	python/Scripts/*.py
INSTALLATION_DIRS+=	share/MaterialX/scripts

post-install:
	${RM} -f ${DESTDIR}${PREFIX}/share/MaterialX/libraries/CMakeLists.txt.orig
	${LN} -sf ${PREFIX}/share/MaterialX/libraries \
		${DESTDIR}${PREFIX}/${PYSITELIB}/MaterialX/libraries
	${INSTALL_SCRIPT} ${WRKSRC}/python/Scripts/*.py \
		${DESTDIR}${PREFIX}/share/MaterialX/scripts
.if ${OPSYS} == "Darwin"
# The Python extension modules link to each other; point their install
# names at site-packages instead of CMAKE_INSTALL_NAME_DIR.
	set -e; cd ${DESTDIR}${PREFIX}/${PYSITELIB}/MaterialX;		\
	for m in Py*.so; do						\
		install_name_tool -id ${PREFIX}/${PYSITELIB}/MaterialX/$$m $$m; \
		for d in Py*.so; do					\
			install_name_tool -change ${PREFIX}/lib/$$d	\
			    ${PREFIX}/${PYSITELIB}/MaterialX/$$d $$m;	\
		done;							\
	done
.endif

.include "../../devel/cmake/build.mk"
.include "../../lang/python/application.mk"
.include "../../lang/python/extension.mk"
.include "../../devel/py-pybind11/buildlink3.mk"
.include "../../graphics/openimageio/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
