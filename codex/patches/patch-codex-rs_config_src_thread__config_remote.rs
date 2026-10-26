$NetBSD$

Allow a model provider on a unix socket (unix_socket in [model_providers.NAME]).

--- codex-rs/config/src/thread_config/remote.rs.orig
+++ codex-rs/config/src/thread_config/remote.rs
@@ -174,6 +174,7 @@ fn model_provider_from_proto(
     let info = ModelProviderInfo {
         name: provider.name,
         base_url: provider.base_url,
+        unix_socket: None,
         model_catalog_url: provider.model_catalog_url.map(Into::into),
         env_key: provider.env_key,
         env_key_instructions: provider.env_key_instructions,
@@ -209,6 +210,7 @@ fn model_provider_to_proto(
     let ModelProviderInfo {
         name,
         base_url,
+        unix_socket: _,
         model_catalog_url,
         env_key,
         env_key_instructions,
