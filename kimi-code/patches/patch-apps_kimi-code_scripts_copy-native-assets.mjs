$NetBSD$

Copy the native helpers of the platforms that were built; pkgsrc
builds only the host one.

--- apps/kimi-code/scripts/copy-native-assets.mjs.orig
+++ apps/kimi-code/scripts/copy-native-assets.mjs
@@ -29,7 +29,8 @@
 await mkdir(target, { recursive: true });
 
 for (const platform of PLATFORMS) {
-  const srcPrebuilds = await assertPrebuilds(platform);
+  const srcPrebuilds = await assertPrebuilds(platform).catch(() => null);
+  if (srcPrebuilds === null) continue;
   const dstPrebuilds = resolve(target, platform, 'prebuilds');
   await cp(srcPrebuilds, dstPrebuilds, { recursive: true });
 }
