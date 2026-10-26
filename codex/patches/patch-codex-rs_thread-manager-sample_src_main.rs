$NetBSD$

agents.multi_agent_version overrides the model's multi-agent tools.  "v1"
gives plain-text spawn_agent and send_input, so subagents on another
model provider can read their tasks; the v2 tools are reserved by the
model and their messages are provider-encrypted.

--- codex-rs/thread-manager-sample/src/main.rs.orig
+++ codex-rs/thread-manager-sample/src/main.rs
@@ -334,6 +334,7 @@
         agent_default_subagent_model: None,
         agent_default_subagent_reasoning_effort: None,
         agent_interrupt_message_enabled: false,
+        agent_multi_agent_version: None,
         agent_max_depth: 1,
         agent_roles: BTreeMap::new(),
         memories: MemoriesConfig::default(),
