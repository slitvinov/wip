$NetBSD$

Let an agent role choose its model provider (model_provider in the role config file).

--- codex-rs/core/src/agent/role.rs.orig
+++ codex-rs/core/src/agent/role.rs
@@ -37,6 +37,7 @@ const AGENT_TYPE_UNAVAILABLE_ERROR: &str = "agent type is currently not availabl
 struct AgentRoleOverrides {
     developer_instructions: Option<String>,
     model: Option<String>,
+    model_provider: Option<String>,
     model_reasoning_effort: Option<ReasoningEffort>,
     model_reasoning_summary: Option<ReasoningSummary>,
     model_verbosity: Option<Verbosity>,
@@ -80,6 +81,7 @@ async fn apply_role_to_config_inner(
     let mut overrides = AgentRoleOverrides {
         developer_instructions: role_config.developer_instructions,
         model: role_config.model,
+        model_provider: role_config.model_provider,
         model_reasoning_effort: role_config.model_reasoning_effort,
         model_reasoning_summary: role_config.model_reasoning_summary,
         model_verbosity: role_config.model_verbosity,
@@ -184,6 +186,14 @@ mod role_overrides {
         if let Some(model) = &overrides.model {
             next_config.model = Some(model.clone());
         }
+        if let Some(id) = &overrides.model_provider {
+            let info = config
+                .model_providers
+                .get(id)
+                .ok_or_else(|| anyhow!("agent role: unknown model provider `{id}`"))?;
+            next_config.model_provider_id = id.clone();
+            next_config.model_provider = info.clone();
+        }
         if let Some(instructions) = &overrides.developer_instructions {
             next_config.developer_instructions = Some(instructions.clone());
         }
