$NetBSD$

Allow a model provider on a unix socket (unix_socket in [model_providers.NAME]).

--- codex-rs/model-provider-info/src/lib.rs.orig
+++ codex-rs/model-provider-info/src/lib.rs
@@ -144,6 +144,9 @@ pub struct ModelProviderInfo {
     pub name: String,
     /// Base URL for the provider's OpenAI-compatible API.
     pub base_url: Option<String>,
+    /// Unix socket to connect to; the base URL host is then not resolved.
+    #[serde(default)]
+    pub unix_socket: Option<String>,
     /// Optional full URL for a Codex-native model catalog. When unset, OpenAI discovery
     /// uses the Codex backend unless `base_url` overrides the inference endpoint.
     pub model_catalog_url: Option<RedactedString>,
@@ -529,6 +532,7 @@ other non-default provider fields are not supported"
         ModelProviderInfo {
             name: OPENAI_PROVIDER_NAME.into(),
             base_url,
+            unix_socket: None,
             model_catalog_url: None,
             env_key: None,
             env_key_instructions: None,
@@ -576,6 +580,7 @@ other non-default provider fields are not supported"
             // this is unset. A configured value is therefore unambiguously an
             // endpoint override.
             base_url: None,
+            unix_socket: None,
             model_catalog_url: None,
             env_key: None,
             env_key_instructions: None,
@@ -758,6 +763,7 @@ pub fn create_oss_provider_with_base_url(base_url: &str, wire_api: WireApi) -> M
     ModelProviderInfo {
         name: "gpt-oss".into(),
         base_url: Some(base_url.into()),
+        unix_socket: None,
         model_catalog_url: None,
         env_key: None,
         env_key_instructions: None,
