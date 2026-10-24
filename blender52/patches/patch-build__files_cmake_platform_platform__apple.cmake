$NetBSD$

Allow building on macOS against pkgsrc libraries instead of Blender's
pre-compiled library directory (enabled with -DWITH_APPLE_SYSTEM_LIBS=ON).

--- build_files/cmake/platform/platform_apple.cmake.orig
+++ build_files/cmake/platform/platform_apple.cmake
@@ -54,10 +54,15 @@
     set(LIBDIR ${CMAKE_SOURCE_DIR}/lib/macos_${CMAKE_OSX_ARCHITECTURES})
   endif()
 endif()
+# pkgsrc: allow building against system (pkgsrc) libraries when the
+# pre-compiled library directory is absent (WITH_APPLE_SYSTEM_LIBS).
 if(NOT EXISTS "${LIBDIR}/.git")
-  message(FATAL_ERROR "Mac OSX requires pre-compiled libs at: '${LIBDIR}'")
-endif()
-if(FIRST_RUN)
+  if(WITH_APPLE_SYSTEM_LIBS)
+    message(STATUS "Pre-compiled LIBDIR not found, using system libraries")
+  else()
+    message(FATAL_ERROR "Mac OSX requires pre-compiled libs at: '${LIBDIR}'")
+  endif()
+elseif(FIRST_RUN)
   message(STATUS "Using pre-compiled LIBDIR: ${LIBDIR}")
 endif()
 
@@ -110,6 +115,7 @@
 
 if(WITH_CODEC_SNDFILE)
   find_package(SndFile)
+  if(NOT WITH_APPLE_SYSTEM_LIBS)
   find_library(_sndfile_FLAC_LIBRARY NAMES flac HINTS ${LIBDIR}/sndfile/lib)
   find_library(_sndfile_OGG_LIBRARY NAMES ogg HINTS ${LIBDIR}/ffmpeg/lib)
   find_library(_sndfile_VORBIS_LIBRARY NAMES vorbis HINTS ${LIBDIR}/ffmpeg/lib)
@@ -120,6 +126,7 @@
     ${_sndfile_VORBIS_LIBRARY}
     ${_sndfile_VORBISENC_LIBRARY}
   )
+  endif()
 
   print_found_status("SndFile libraries" "${LIBSNDFILE_LIBRARIES}")
   unset(_sndfile_FLAC_LIBRARY)
@@ -140,10 +147,15 @@
 
 # FreeType compiled with Brotli compression for woff2.
 find_package(Freetype REQUIRED)
+if(WITH_APPLE_SYSTEM_LIBS)
+  # Shared FreeType already links against Brotli.
+  set(BROTLI_LIBRARIES "")
+else()
 set(BROTLI_LIBRARIES
   ${LIBDIR}/brotli/lib/libbrotlicommon-static.a
   ${LIBDIR}/brotli/lib/libbrotlidec-static.a
 )
+endif()
 
 if(WITH_HARFBUZZ)
   find_package(Harfbuzz)
@@ -166,12 +178,18 @@
 )
 
 if(WITH_CODEC_FFMPEG)
+  if(WITH_APPLE_SYSTEM_LIBS)
+    # Shared FFmpeg libraries carry their own codec dependencies.
+    set(FFMPEG_FIND_COMPONENTS
+      avcodec avdevice avfilter avformat avutil swresample swscale)
+  else()
   set(FFMPEG_ROOT_DIR ${LIBDIR}/ffmpeg)
   set(FFMPEG_FIND_COMPONENTS
     avcodec avdevice avfilter avformat avutil
     mp3lame ogg opus swresample swscale
     theora theoradec theoraenc vorbis vorbisenc
     vorbisfile vpx x264)
+  endif()
   # Frameworks required by libavfilter, using legacy macOS CGL
   string(APPEND PLATFORM_LINKFLAGS " -framework CoreImage -framework OpenGL")
   if(EXISTS ${LIBDIR}/ffmpeg/lib/libaom.a)
