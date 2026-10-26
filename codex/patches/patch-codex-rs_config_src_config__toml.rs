$NetBSD$

agents.multi_agent_version overrides the model's multi-agent tools.  "v1"
gives plain-text spawn_agent and send_input, so subagents on another
model provider can read their tasks; the v2 tools are reserved by the
model and their messages are provider-encrypted.

--- codex-rs/config/src/config_toml.rs.orig
+++ codex-rs/config/src/config_toml.rs
@@ -778,6 +778,11 @@
     /// Whether to record a model-visible message when an agent turn is interrupted.
     /// Defaults to true.
     pub interrupt_message: Option<bool>,
+    /// Multi-agent tools to offer, overriding the model's own preference:
+    /// "v1" gives plain-text spawn_agent and send_input, which subagents on
+    /// another model provider can read; "v2" gives the model-reserved
+    /// tools whose messages may be provider-encrypted.
+    pub multi_agent_version: Option<codex_protocol::protocol::MultiAgentVersion>,
 
     /// User-defined role declarations keyed by role name.
     ///
