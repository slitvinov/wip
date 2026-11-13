# $NetBSD$

PKG_OPTIONS_VAR=	PKG_OPTIONS.ospray
PKG_SUPPORTED_OPTIONS=	mpi
PKG_SUGGESTED_OPTIONS=	mpi

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		mpi

# MPI distributed rendering (mpi_offload and mpi_distributed_cpu modules,
# ospray_mpi_worker and the ospMPIDistrib* examples).
.if !empty(PKG_OPTIONS:Mmpi)
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_MPI=ON
# Point FindMPI at the wrappers of the MPI implementation in use.
CMAKE_CONFIGURE_ARGS+=	-DMPI_C_COMPILER=${BUILDLINK_PREFIX.${MPI_TYPE}:U${LOCALBASE}}/bin/mpicc
CMAKE_CONFIGURE_ARGS+=	-DMPI_CXX_COMPILER=${BUILDLINK_PREFIX.${MPI_TYPE}:U${LOCALBASE}}/bin/mpicxx
PLIST.mpi=		yes
.include "../../devel/snappy/buildlink3.mk"
.include "../../mk/mpi.buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_MPI=OFF
.endif
