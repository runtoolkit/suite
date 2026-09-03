# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/from_input_as
# Execute as a specific selector
#
# INPUT (storage macroengine:input):
# list → command list
# selector → entity selector (default: @s)
# ─────────────────────────────────────────────────────────────────

execute unless data storage macroengine:input selector run data modify storage macroengine:input selector set value "@s"

data modify storage macroengine:engine _mcmd_queue set from storage macroengine:input list
data modify storage macroengine:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}

function macroengine:core/internal/api/cmd/other/multi_cmd/run_as_exec with storage macroengine:input
