# macro:api/cmd/other/multi_cmd/advanced/run_with_options
# Run with advanced options.
#
# INPUT (storage macro:input):
#   list    → command list (string or object)
#   options → {priority_sort:1b, spread_ticks:0, error_mode:"continue", profile:1b, type:"..."}
#
# SECURITY: if options.type is set, validates it against multi_type_allowlist.
# Invalid type → type_violation (log + kick) + abort.

data modify storage macro:engine _mcmd_queue set from storage macro:input list
execute unless data storage macro:input options run data modify storage macro:input options set value {}
data modify storage macro:engine _mcmd_options merge from storage macro:input options

# Validate options.type if caller explicitly specified one
execute if data storage macro:engine _mcmd_options.type run data modify storage macro:engine multiCommands.type set from storage macro:engine _mcmd_options.type
execute if data storage macro:engine _mcmd_options.type run execute unless function macro:core/security/multi_type_check run return 0

execute unless data storage macro:engine _mcmd_options.error_mode run data modify storage macro:engine _mcmd_options.error_mode set value "continue"
execute unless data storage macro:engine _mcmd_options.profile run data modify storage macro:engine _mcmd_options.profile set value 0b
execute unless data storage macro:engine _mcmd_options.spread_ticks run data modify storage macro:engine _mcmd_options.spread_ticks set value 0

execute if data storage macro:engine _mcmd_options{priority_sort:1b} run function macro:api/cmd/other/multi_cmd/advanced/internal/sort_by_priority
execute if data storage macro:engine _mcmd_options.spread_ticks unless data storage macro:engine _mcmd_options{spread_ticks:0} run return run function macro:api/cmd/other/multi_cmd/advanced/internal/run_spread

function macro:api/cmd/other/multi_cmd/run
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/advanced ","color":"aqua"},{"text":"✔ with options","color":"green"}]
