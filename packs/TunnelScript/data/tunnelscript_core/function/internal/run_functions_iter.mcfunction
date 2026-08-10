# Runs storage tunnelscript_core:work flist[] (function ids) once each.
execute unless data storage tunnelscript_core:work flist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work fone set value {}
data modify storage tunnelscript_core:work fone.func set from storage tunnelscript_core:work flist[0]
data remove storage tunnelscript_core:work flist[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:handlers/function with storage tunnelscript_core:work fone
function tunnelscript_core:internal/run_functions_iter
