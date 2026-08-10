# Run one command from the list, then continue the iterator.
scoreboard players remove #counter tunnelscript.vars 1
data modify storage tunnelscript:in cmd set from storage tunnelscript_core:work clist[0]
data remove storage tunnelscript_core:work clist[0]
function tunnelscript_core:internal/run_block
schedule function tunnelscript_core:internal/run_commands_iter 2t