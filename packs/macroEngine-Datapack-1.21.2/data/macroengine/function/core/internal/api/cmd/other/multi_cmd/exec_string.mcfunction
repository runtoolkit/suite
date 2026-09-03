# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/internal/exec_string
# Execute simple string command
# _mcmd_current is a plain string e.g. "say Hello"
# ─────────────────────────────────────────────────────────────────

# Wrap string into object
data modify storage macroengine:engine _mcmd_exec set value {}
data modify storage macroengine:engine _mcmd_exec.cmd set from storage macroengine:engine _mcmd_current

# Execute via macro
function macroengine:core/internal/api/cmd/other/multi_cmd/exec_macro with storage macroengine:engine _mcmd_exec

# Cleanup
data remove storage macroengine:engine _mcmd_exec
