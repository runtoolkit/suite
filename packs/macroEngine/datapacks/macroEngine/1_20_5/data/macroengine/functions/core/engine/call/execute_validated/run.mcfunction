# ─────────────────────────────────────────────
# macroengine:core/engine/call/execute_validated/run
# Expands and runs the validated function via macroengine.
# Gets $(func) variable from macroengine:output.inputs storage,
# uses macroengine:input storage as the parameter source.
# ─────────────────────────────────────────────

$function $(func) with storage macroengine:input {}
