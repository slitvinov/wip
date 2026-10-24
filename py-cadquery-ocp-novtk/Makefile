# $NetBSD$

OCP_VERSION=	8.0.1.1
DISTNAME=	OCP_src_stubs_OSX
PKGNAME=	${PYPKGPREFIX}-cadquery-ocp-novtk-${OCP_VERSION}
CATEGORIES=	cad python
MASTER_SITES=	${MASTER_SITE_GITHUB:=CadQuery/OCP/releases/download/${OCP_VERSION}/}
DIST_SUBDIR=	cadquery-ocp-${OCP_VERSION}
EXTRACT_SUFX=	.zip

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/CadQuery/OCP
COMMENT=	Python bindings for OpenCascade (OCCT), without VTK
LICENSE=	apache-2.0

# The distfile is the pybind11 C++ source that upstream generates from
# the OCCT 8.0.1 headers with pywrap (libclang) and publishes with each
# release, so pywrap does not have to run here.  It extracts flat.
EXTRACT_DIR=	${WRKDIR}/OCP
WRKSRC=		${WRKDIR}/OCP

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

# The ~650 generated translation units need up to 2.5 GB of RAM each
# in the compiler (gp.cpp, Graphic3d.cpp); with 24 GB use MAKE_JOBS=8.
CMAKE_CONFIGURE_ARGS+=	-DPython_EXECUTABLE=${PYTHONBIN}
CMAKE_CONFIGURE_ARGS+=	-DPYTHON_SP_DIR=${PREFIX}/${PYSITELIB}
CMAKE_CONFIGURE_ARGS+=	-DOpenCASCADE_DIR=${BUILDLINK_PREFIX.occt}/lib/cmake/opencascade
CMAKE_CONFIGURE_ARGS+=	-Dpybind11_DIR=${PREFIX}/${PYSITELIB}/pybind11/share/cmake/pybind11
# The generated code triggers tens of thousands of warnings.
CXXFLAGS+=		-w

# This is the "novtk" variant (PyPI cadquery-ocp-novtk), as upstream
# builds it in CadQuery/ocp-build-system: drop the IVtk* modules (they
# need VTK) and their uses in the module registry and collections.
# patch-CMakeLists.txt removes VTK from the build.
SUBST_CLASSES+=		novtk
SUBST_STAGE.novtk=	post-extract
SUBST_MESSAGE.novtk=	Removing the IVtk bindings.
SUBST_FILES.novtk=	*.cpp
SUBST_NOOP_OK.novtk=	yes
SUBST_SED.novtk=	-e '/register_IVtk/d'
SUBST_SED.novtk+=	-e '/\#include <IVtk_[A-Za-z_]*\.hxx>/d'
SUBST_SED.novtk+=	-e '/register_template_NCollection_[A-Za-z]*<IVtk_/d'

post-extract:
	${RM} -f ${WRKSRC}/IVtk*
	${RM} -rf ${WRKSRC}/OCP-stubs

PY_DISTINFO=		cadquery_ocp_novtk-${OCP_VERSION}.dist-info
INSTALLATION_DIRS+=	${PYSITELIB}/${PY_DISTINFO}

# Install metadata so that importlib.metadata and pip see the
# distribution that build123d, ocpsvg and ocp_gordon require.
post-install:
	${PRINTF} 'Metadata-Version: 2.1\nName: cadquery-ocp-novtk\nVersion: %s\nSummary: %s\nLicense: Apache-2.0\n' \
		${OCP_VERSION:Q} ${COMMENT:Q} \
		> ${DESTDIR}${PREFIX}/${PYSITELIB}/${PY_DISTINFO}/METADATA
	${ECHO} OCP > ${DESTDIR}${PREFIX}/${PYSITELIB}/${PY_DISTINFO}/top_level.txt
	${ECHO} pkgsrc > ${DESTDIR}${PREFIX}/${PYSITELIB}/${PY_DISTINFO}/INSTALLER

.include "../../devel/cmake/build.mk"
PY_PATCHPLIST=	yes
.include "../../lang/python/extension.mk"
BUILDLINK_API_DEPENDS.occt+=	occt>=8.0.1<8.1
.include "../../wip/occt/buildlink3.mk"
.include "../../devel/py-pybind11/buildlink3.mk"
.include "../../textproc/fmtlib/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
