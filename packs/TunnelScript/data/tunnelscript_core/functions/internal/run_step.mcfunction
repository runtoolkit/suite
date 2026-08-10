# Extract the current action, decrement counter, dispatch if it's a cmd type.
scoreboard players remove #counter tunnelscript.vars 1
data modify storage tunnelscript_core:work current set from storage tunnelscript_core:work actions[0]
data remove storage tunnelscript_core:work actions[0]
# Only cmd / command action types map to a raw command string.
# Everything else is skipped (needs macros for dynamic dispatch).
execute if data storage tunnelscript_core:work current{type:"cmd"} run function tunnelscript_core:internal/run_cmd_step
execute if data storage tunnelscript_core:work current{type:"command"} run function tunnelscript_core:internal/run_cmd_step
# Continue iteration (the step above already ran run_block + cleanup schedule).
function tunnelscript_core:internal/run_iter
