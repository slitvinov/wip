$NetBSD$

Build with OpenEXR 3.x: Imf::Int64 is gone (use uint64_t) and
ImfFrameBuffer.h is no longer included by the other headers.

--- src/core/bitmap.cpp.orig	2026-10-24 00:48:41
+++ src/core/bitmap.cpp	2026-10-24 00:48:41
@@ -54,6 +54,7 @@
 #include <ImfMatrixAttribute.h>
 #include <ImfVersion.h>
 #include <ImfIO.h>
+#include <ImfFrameBuffer.h>
 #include <ImathBox.h>
 #include <IlmThreadPool.h>
 
@@ -925,11 +926,11 @@
         return m_stream->tell() == m_size;
     }
 
-    Imf::Int64 tellg() override {
+    uint64_t tellg() override {
         return m_stream->tell()-m_offset;
     }
 
-    void seekg(Imf::Int64 pos) override {
+    void seekg(uint64_t pos) override {
         m_stream->seek((size_t) pos + m_offset);
     }
 
@@ -945,8 +946,8 @@
         m_stream(stream) { }
 
     void write(const char *c, int n) override { m_stream->write(c, n); }
-    Imf::Int64 tellp() override { return m_stream->tell(); }
-    void seekp(Imf::Int64 pos) override { m_stream->seek((size_t) pos); }
+    uint64_t tellp() override { return m_stream->tell(); }
+    void seekp(uint64_t pos) override { m_stream->seek((size_t) pos); }
 private:
     ref<Stream> m_stream;
 };
