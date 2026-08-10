# Processes storage tunnelscript_core:work actions[] exactly once.
# Stops when the list is empty or the per-run action budget is exhausted.
# This is a finite recursion over a shrinking list, never an auto-repeat.
execute unless data storage tunnelscript_core:work actions[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work current set from storage tunnelscript_core:work actions[0]
data remove storage tunnelscript_core:work actions[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:internal/dispatch with storage tunnelscript_core:work current
function tunnelscript_core:internal/iterate
