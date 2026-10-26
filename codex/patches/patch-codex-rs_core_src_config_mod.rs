$NetBSD$

agents.multi_agent_version overrides the model's multi-agent tools.  "v1"
gives plain-text spawn_agent and send_input, so subagents on another
model provider can read their tasks; the v2 tools are reserved by the
model and their messages are provider-encrypted.

--- codex-rs/core/src/config/mod.rs.orig
+++ codex-rs/core/src/config/mod.rs
@@ -976,6 +976,9 @@
     /// Whether to record a model-visible message when an agent turn is interrupted.
     pub agent_interrupt_message_enabled: bool,
 
+    /// Multi-agent tool version from agents.multi_agent_version, if set.
+    pub agent_multi_agent_version: Option<MultiAgentVersion>,
+
     /// Maximum nesting depth for V1 agent threads. Ignored by V2.
     pub agent_max_depth: i32,
 
@@ -1661,7 +1664,7 @@
         } else if !self.agents_enabled {
             Some(MultiAgentVersion::Disabled)
         } else {
-            None
+            self.agent_multi_agent_version
         }
     }
 
@@ -4064,6 +4067,10 @@
             .as_ref()
             .and_then(|agents| agents.interrupt_message)
             .unwrap_or(true);
+        let agent_multi_agent_version = cfg
+            .agents
+            .as_ref()
+            .and_then(|agents| agents.multi_agent_version);
         let background_terminal_max_timeout = cfg
             .background_terminal_max_timeout
             .unwrap_or(DEFAULT_MAX_BACKGROUND_TERMINAL_TIMEOUT_MS)
@@ -4561,6 +4568,7 @@
                 .transpose()?,
             memories: memories_config,
             agent_interrupt_message_enabled,
+            agent_multi_agent_version,
             codex_home,
             sqlite,
             log_dir,
