$NetBSD$

Allow a model provider on a unix socket (unix_socket in [model_providers.NAME]).

--- codex-rs/login/src/auth/default_client.rs.orig
+++ codex-rs/login/src/auth/default_client.rs
@@ -268,6 +268,17 @@ pub fn create_client_for_route(
     create_client_for_route_with_builder(http_client_factory, request_url, route_class, builder)
 }
 
+pub fn create_client_for_unix_socket(
+    path: &str,
+    redirect_policy: ClientRedirectPolicy,
+) -> Result<HttpClient, codex_http_client::BuildCustomCaTransportError> {
+    let builder = match redirect_policy {
+        ClientRedirectPolicy::Default => default_http_client_builder(),
+        ClientRedirectPolicy::Reject => default_http_client_builder().without_redirects(),
+    };
+    builder.unix_socket(path).build_direct()
+}
+
 fn create_client_for_route_with_builder(
     http_client_factory: &HttpClientFactory,
     request_url: &str,
