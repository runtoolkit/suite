# ─────────────────────────────────────────────
# macroengine:core/engine/call/execute_validated
# Runs a function that has passed security validation.
# Called only by macroengine:debug/tools/utils/input_check.
#
# Girdi (macroengine:output.inputs):
# func — function name to run (already validated)
# Veri (macroengine:input):
# All parameters to pass to the function
# ─────────────────────────────────────────────

# Pass validated func name to macro sub-function and run
function macroengine:core/engine/call/execute_validated/run with storage macroengine:output inputs
