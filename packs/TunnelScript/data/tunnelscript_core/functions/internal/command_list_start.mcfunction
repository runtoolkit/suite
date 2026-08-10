# Shared setup for any list of full command strings.
# Used by ts:run_commands and ts:run_functions so both go through one iterator.
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/run_commands_iter
