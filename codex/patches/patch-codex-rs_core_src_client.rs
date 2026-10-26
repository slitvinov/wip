$NetBSD$

Allow a model provider on a unix socket (unix_socket in [model_providers.NAME]).

--- codex-rs/core/src/client.rs.orig
+++ codex-rs/core/src/client.rs
@@ -79,6 +79,7 @@ use codex_login::UnauthorizedRecovery;
 use codex_login::default_client::ClientRedirectPolicy;
 use codex_login::default_client::add_originator_header;
 use codex_login::default_client::create_client_for_route;
+use codex_login::default_client::create_client_for_unix_socket;
 use codex_otel::SessionTelemetry;
 use codex_otel::WEBSOCKET_CONTINUATION_COUNT_METRIC;
 use codex_otel::current_span_w3c_trace_context;
@@ -1309,13 +1310,18 @@ impl ModelClient {
         } else {
             redirect_policy
         };
-        let client = create_client_for_route(
-            &self.http_client_factory,
-            &api_provider.url_for_path(endpoint),
-            ClientRouteClass::Api,
-            redirect_policy,
-        )
-        .map_err(std::io::Error::from)?;
+        let client = match self.state.provider.info().unix_socket.as_deref() {
+            Some(path) => {
+                create_client_for_unix_socket(path, redirect_policy).map_err(std::io::Error::other)?
+            }
+            None => create_client_for_route(
+                &self.http_client_factory,
+                &api_provider.url_for_path(endpoint),
+                ClientRouteClass::Api,
+                redirect_policy,
+            )
+            .map_err(std::io::Error::from)?,
+        };
         Ok(ReqwestTransport::from_http_client(client))
     }
 
