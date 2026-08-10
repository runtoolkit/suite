# Runs storage tunnelscript_core:work clist[] (raw command strings) once each.
execute unless data storage tunnelscript_core:work clist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work cone set value {}
data modify storage tunnelscript_core:work cone.value set from storage tunnelscript_core:work clist[0]
data remove storage tunnelscript_core:work clist[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:handlers/cmd with storage tunnelscript_core:work cone
function tunnelscript_core:internal/run_commands_iter
