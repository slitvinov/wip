$NetBSD$

Work without the offline metal compiler: resolve the project includes
in the shell instead of with `metal -E -H`.  Also accept a whole
kernel file (foo.metal), exported as foo_metal().

--- mlx/backend/metal/make_compiled_preamble.sh.orig
+++ mlx/backend/metal/make_compiled_preamble.sh
@@ -25,11 +25,42 @@ CFLAGS=$5
 SRC_NAME=$(basename -- "${SRC_FILE}")
 JIT_INCLUDES=${SRC_DIR}/mlx/backend/metal/kernels/jit
 INPUT_FILE=${SRC_DIR}/mlx/backend/metal/kernels/${SRC_FILE}.h
+# A complete kernel file (foo.metal) yields the function foo_metal().  Used
+# for MLX_METAL_RUNTIME_COMPILE, which compiles these files at runtime
+# instead of linking them into mlx.metallib.
+case "${SRC_FILE}" in
+*.metal)
+  SRC_NAME=$(basename -- "${SRC_FILE}" .metal)_metal
+  INPUT_FILE=${SRC_DIR}/mlx/backend/metal/kernels/${SRC_FILE}
+  ;;
+esac
 OUTPUT_FILE=${OUTPUT_DIR}/${SRC_NAME}.cpp
 
 # Prepare output
 mkdir -p "$OUTPUT_DIR"
 
+if ! xcrun -sdk macosx -f metal >/dev/null 2>&1; then
+  # No offline metal compiler (Command Line Tools without Xcode): resolve the
+  # quoted project includes ourselves, depth first, so that every header
+  # follows its own dependencies, as the sorted -H output below does.  The
+  # kernel headers include each other unconditionally, so preprocessor
+  # conditionals need not be evaluated.
+  declare -a HDRS_SORTED=()
+  declare -a HDRS_SEEN=()
+  resolve_includes() {
+    local inc
+    for inc in $(sed -n -E 's/^[[:space:]]*#[[:space:]]*include[[:space:]]+"([^"]+)".*/\1/p' "$1"); do
+      case " ${HDRS_SEEN[*]} " in
+      *" ${inc} "*) continue ;;
+      esac
+      HDRS_SEEN+=("${inc}")
+      resolve_includes "${SRC_DIR}/${inc}"
+      HDRS_SORTED+=("${inc}")
+    done
+  }
+  resolve_includes "${INPUT_FILE}"
+else
+
 # Use the metal compiler to get a list of headers (with depth)
 CCC="xcrun -sdk macosx metal -x metal"
 HDRS=$( $CCC -I"$SRC_DIR" -I"$JIT_INCLUDES" -DMLX_METAL_JIT -E -P -CC -C -H "$INPUT_FILE" $CFLAGS -w 2>&1 1>/dev/null )
@@ -99,6 +130,8 @@ do
 
 done
 
+fi # metal compiler available
+
 # Make sure the given metal header is also expanded in the source content
 HDRS_SORTED+=("${INPUT_FILE#$SRC_DIR/}")
 
