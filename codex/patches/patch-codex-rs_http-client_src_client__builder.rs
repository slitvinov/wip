$NetBSD$

Allow a model provider on a unix socket (unix_socket in [model_providers.NAME]).

--- codex-rs/http-client/src/client_builder.rs.orig
+++ codex-rs/http-client/src/client_builder.rs
@@ -46,6 +46,7 @@ pub struct HttpClientBuilder {
     pub(crate) tls: HttpClientTlsConfig,
     #[cfg(windows)]
     windows_proxy_pipe_path: Option<std::path::PathBuf>,
+    unix_socket_path: Option<String>,
 }
 
 #[derive(Clone, Copy, Debug, Default, Eq, PartialEq)]
@@ -144,6 +145,11 @@ impl HttpClientBuilder {
     }
 
     /// Limits only connection establishment, not the request as a whole.
+    pub fn unix_socket(mut self, path: impl Into<String>) -> Self {
+        self.unix_socket_path = Some(path.into());
+        self
+    }
+
     pub fn connect_timeout(mut self, timeout: Duration) -> Self {
         self.connect_timeout = Some(timeout);
         self
@@ -384,6 +390,10 @@ impl HttpClientBuilder {
         if let Some(path) = self.windows_proxy_pipe_path {
             builder = builder.windows_named_pipe(path);
         }
+        #[cfg(unix)]
+        if let Some(path) = self.unix_socket_path {
+            builder = builder.unix_socket(path);
+        }
         if self.http2_prior_knowledge {
             builder = builder.http2_prior_knowledge();
         }
@@ -435,6 +445,7 @@ impl Default for HttpClientBuilder {
             tls: HttpClientTlsConfig::default(),
             #[cfg(windows)]
             windows_proxy_pipe_path: None,
+            unix_socket_path: None,
         }
     }
 }
