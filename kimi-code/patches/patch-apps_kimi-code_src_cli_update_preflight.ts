$NetBSD$

Updates come from pkgsrc: never check for, download or install them.

--- apps/kimi-code/src/cli/update/preflight.ts.orig
+++ apps/kimi-code/src/cli/update/preflight.ts
@@ -497,10 +497,8 @@
  * from kimi-cli, where the variable gated all auto-update behavior. Accepts
  * the usual truthy values (`1`/`true`/`yes`/`on`).
  */
-export function isAutoUpdateDisabledByEnv(env: NodeJS.ProcessEnv = process.env): boolean {
-  const truthy = (value?: string): boolean =>
-    ['1', 'true', 'yes', 'on'].includes((value ?? '').trim().toLowerCase());
-  return truthy(env['KIMI_CODE_NO_AUTO_UPDATE']) || truthy(env['KIMI_CLI_NO_AUTO_UPDATE']);
+export function isAutoUpdateDisabledByEnv(_env: NodeJS.ProcessEnv = process.env): boolean {
+  return true;
 }
 
 /**
