# $NetBSD$

# OVITO 3.17.1 was released on 2026-10-26 but the source repository has
# no tag for it yet; this is the release commit (Version.cmake: 3.17.1).
OVITO_COMMIT=		8c76f5262598135dfcbdf04778a2e7bf93dee4eb
DISTNAME=		ovito-${OVITO_COMMIT}
PKGNAME=		ovito-3.17.1
CATEGORIES=		graphics
MASTER_SITES=		${MASTER_SITE_GITLAB:=stuko/ovito/-/archive/${OVITO_COMMIT}/}
# Upstream builds zstd (and its zlib wrapper sources, which pkgsrc's zstd
# does not install) from a git submodule that is missing in the archive.
ZSTD_DISTFILE=		zstd-1.5.7.tar.gz
DISTFILES=		${DEFAULT_DISTFILES} ${ZSTD_DISTFILE}
SITES.${ZSTD_DISTFILE}=	-https://github.com/facebook/zstd/archive/v1.5.7.tar.gz

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.ovito.org/
COMMENT=	Visualization and analysis of particle-based simulation data
LICENSE=	gnu-gpl-v3 OR mit

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++23
USE_TOOLS+=		pkg-config

.include "../../mk/bsd.prefs.mk"

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DBUILD_TESTING=OFF
CMAKE_CONFIGURE_ARGS+=	-DOVITO_BUILD_DOCUMENTATION=OFF
# The libssh-based built-in SSH client for remote file access.
CMAKE_CONFIGURE_ARGS+=	-DOVITO_BUILD_SSH_CLIENT=ON
# Do not phone home for updates.
CMAKE_CONFIGURE_ARGS+=	-DOVITO_BUILD_APPSTORE_VERSION=ON
# OVITO only links NetCDF; FindHDF5 in config mode trips over targets
# (ZLIB::ZLIB, libaec::sz) that the HDF5 CMake config does not import.
CMAKE_CONFIGURE_ARGS+=	-DHDF5_NO_FIND_PACKAGE_CONFIG_FILE=ON
# ffmpeg7 installs its headers and libraries in versioned subdirectories.
CMAKE_CONFIGURE_ARGS+=	-DFFMPEG_INCLUDE_DIR=${BUILDLINK_DIR}/include/ffmpeg7
CMAKE_CONFIGURE_ARGS+=	-DFFMPEG_LIBRARY_DIR=${BUILDLINK_DIR}/lib/ffmpeg7
# OVITO_BUILD_BASIC only adds the "OVITO Basic" watermark to rendered
# images; the Python module (PyScript) and the Tachyon, OSPRay, VisRTX
# and ANARI renderers are proprietary (OVITO Pro) and not in the source.

post-extract:
	rmdir ${WRKSRC}/src/3rdparty/zstd
	${MV} ${WRKDIR}/zstd-1.5.7 ${WRKSRC}/src/3rdparty/zstd

.if ${OPSYS} == "Darwin"
# Keep upstream's @rpath install names during the build (the libraries
# live in two bundle directories); post-install turns them into absolute
# paths in the installed bundle, see files/fix-install-names.sh.
CMAKE_INSTALL_NAME_DIR=	@rpath
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
# CMake installs ${PREFIX}/Ovito.app; move it to ${PREFIX}/Applications
# and provide a launcher in bin.
INSTALLATION_DIRS+=	Applications bin

post-install:
	${RM} -rf ${DESTDIR}${PREFIX}/Applications/Ovito.app
	${MV} ${DESTDIR}${PREFIX}/Ovito.app ${DESTDIR}${PREFIX}/Applications/
	${SH} ${FILESDIR}/fix-install-names.sh \
	    ${DESTDIR}${PREFIX}/Applications/Ovito.app \
	    ${PREFIX}/Applications/Ovito.app
	${PRINTF} '#!/bin/sh\nexec "%s" "$$@"\n' \
	    "${PREFIX}/Applications/Ovito.app/Contents/MacOS/ovito" \
	    > ${DESTDIR}${PREFIX}/bin/ovito
	${CHMOD} ${BINMODE} ${DESTDIR}${PREFIX}/bin/ovito
.endif

.include "../../devel/cmake/build.mk"
.include "../../archivers/bzip2/buildlink3.mk"
.include "../../databases/sqlite3/buildlink3.mk"
.include "../../devel/boost-headers/buildlink3.mk"
.include "../../devel/hdf5/buildlink3.mk"
.include "../../devel/netcdf/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../multimedia/ffmpeg7/buildlink3.mk"
.include "../../security/libssh/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../x11/qt6-qtbase/buildlink3.mk"
.include "../../graphics/qt6-qtshadertools/buildlink3.mk"
.include "../../graphics/qt6-qtsvg/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
