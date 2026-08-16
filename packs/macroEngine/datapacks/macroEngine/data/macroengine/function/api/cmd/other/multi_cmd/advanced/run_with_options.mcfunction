# macroengine:api/cmd/other/multi_cmd/advanced/run_with_options
# Run with advanced options.
#
# INPUT (storage macroengine:input):
#   list    → command list (string or object)
#   options → {priority_sort:1b, spread_ticks:0, error_mode:"continue", profile:1b, type:"..."}
#
# SECURITY: if options.type is set, validates it against multi_type_allowlist.
# Invalid type → type_violation (log + kick) + abort.

data modify storage macroengine:engine _mcmd_queue set from storage macroengine:input list
execute unless data storage macroengine:input options run data modify storage macroengine:input options set value {}
data modify storage macroengine:engine _mcmd_options merge from storage macroengine:input options

# Validate options.type if caller explicitly specified one
execute if data storage macroengine:engine _mcmd_options.type run data modify storage macroengine:engine multiCommands.type set from storage macroengine:engine _mcmd_options.type

execute unless data storage macroengine:engine _mcmd_options.error_mode run data modify storage macroengine:engine _mcmd_options.error_mode set value "continue"
execute unless data storage macroengine:engine _mcmd_options.profile run data modify storage macroengine:engine _mcmd_options.profile set value 0b
execute unless data storage macroengine:engine _mcmd_options.spread_ticks run data modify storage macroengine:engine _mcmd_options.spread_ticks set value 0

execute if data storage macroengine:engine _mcmd_options{priority_sort:1b} run function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/sort_by_priority
execute if data storage macroengine:engine _mcmd_options.spread_ticks unless data storage macroengine:engine _mcmd_options{spread_ticks:0} run return run function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/run_spread

function macroengine:api/cmd/other/multi_cmd/run
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/advanced ","color":"aqua"},{"text":"✔ with options","color":"green"}]
