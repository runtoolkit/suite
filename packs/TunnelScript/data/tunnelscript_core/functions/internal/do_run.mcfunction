# Copy the action list and start the bounded iterator.
data modify storage tunnelscript_core:work actions set from storage tunnelscript:in actions
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/run_iter
