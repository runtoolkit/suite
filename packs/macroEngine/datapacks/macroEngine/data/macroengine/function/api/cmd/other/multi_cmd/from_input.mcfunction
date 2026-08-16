# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/from_input
# Execute a simple command list (backward compatible)
#
# INPUT (storage macroengine:input):
# list → command list ["cmd1", "cmd2", ...]
#
# EXAMPLE:
# data modify storage macroengine:input list set value ["say Hello", "say World"]
# function macroengine:api/cmd/other/multi_cmd/from_input
# ─────────────────────────────────────────────────────────────────

# Copy list to queue
data modify storage macroengine:engine _mcmd_queue set from storage macroengine:input list

# Set default options
data modify storage macroengine:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}

# Execute
function macroengine:api/cmd/other/multi_cmd/run

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/from_input ","color":"aqua"},{"text":"▶ list → run","color":"#555555"}]
