# $NetBSD$

PKG_OPTIONS_VAR=		PKG_OPTIONS.blender52
PKG_SUPPORTED_OPTIONS=		alembic draco embree jack libmv manifold meshoptimizer
PKG_SUPPORTED_OPTIONS+=		oidn openpgl opensubdiv openvdb
PKG_SUGGESTED_OPTIONS=		alembic draco embree libmv manifold meshoptimizer
PKG_SUGGESTED_OPTIONS+=		oidn openpgl opensubdiv openvdb

.include "../../mk/bsd.fast.prefs.mk"

.if ${OPSYS} != "Darwin"
PKG_SUPPORTED_OPTIONS+=		pulseaudio
.endif

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		draco meshoptimizer

# Alembic import/export.
.if !empty(PKG_OPTIONS:Malembic)
CMAKE_CONFIGURE_ARGS+=	-DWITH_ALEMBIC=ON
.include "../../wip/alembic/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_ALEMBIC=OFF
.endif

# Draco mesh compression for the glTF add-on (loaded at run time
# through the bf_intern_draco_bridge library).
.if !empty(PKG_OPTIONS:Mdraco)
CMAKE_CONFIGURE_ARGS+=	-DWITH_DRACO=ON
PLIST.draco=		yes
.include "../../geography/draco/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_DRACO=OFF
.endif

# Embree ray tracing kernels for Cycles CPU rendering.
.if !empty(PKG_OPTIONS:Membree)
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_EMBREE=ON
.include "../../wip/embree/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_EMBREE=OFF
.endif

.if !empty(PKG_OPTIONS:Mjack)
CMAKE_CONFIGURE_ARGS+=	-DWITH_JACK=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_JACK_DYNLOAD=OFF
.include "../../audio/jack/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_JACK=OFF
.endif

# Motion tracking (libmv); its camera solver needs Ceres.
.if !empty(PKG_OPTIONS:Mlibmv)
CMAKE_CONFIGURE_ARGS+=	-DWITH_LIBMV=ON
.include "../../wip/ceres-solver/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_LIBMV=OFF
.endif

# Manifold solver for the Boolean modifier and geometry node.
.if !empty(PKG_OPTIONS:Mmanifold)
CMAKE_CONFIGURE_ARGS+=	-DWITH_MANIFOLD=ON
.include "../../wip/manifold/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_MANIFOLD=OFF
.endif

# meshoptimizer (EXT_meshopt_compression) for the glTF add-on, loaded
# at run time through the bf_intern_meshopt_bridge library.
.if !empty(PKG_OPTIONS:Mmeshoptimizer)
CMAKE_CONFIGURE_ARGS+=	-DWITH_MESHOPTIMIZER=ON
PLIST.meshoptimizer=	yes
.include "../../wip/meshoptimizer/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_MESHOPTIMIZER=OFF
.endif

# Intel Open Image Denoise (CPU; Metal device needs the Metal compiler).
.if !empty(PKG_OPTIONS:Moidn)
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENIMAGEDENOISE=ON
.include "../../wip/oidn/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENIMAGEDENOISE=OFF
.endif

# Path guiding for Cycles (CPU device only).
.if !empty(PKG_OPTIONS:Mopenpgl)
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_PATH_GUIDING=ON
.include "../../wip/openpgl/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_PATH_GUIDING=OFF
.endif

.if !empty(PKG_OPTIONS:Mopensubdiv)
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENSUBDIV=ON
.include "../../wip/opensubdiv/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENSUBDIV=OFF
.endif

# OpenVDB volumes; NanoVDB (shipped with OpenVDB) for GPU volume rendering.
.if !empty(PKG_OPTIONS:Mopenvdb)
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENVDB=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_NANOVDB=ON
.include "../../wip/openvdb/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENVDB=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_NANOVDB=OFF
.endif

.if !empty(PKG_OPTIONS:Mpulseaudio)
CMAKE_CONFIGURE_ARGS+=	-DWITH_PULSEAUDIO=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_PULSEAUDIO_DYNLOAD=OFF
.include "../../audio/pulseaudio/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_PULSEAUDIO=OFF
.endif
