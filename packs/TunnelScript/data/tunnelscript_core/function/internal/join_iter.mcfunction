# Internal: consume jlist[] one item at a time, appending to out.joined.
execute unless data storage tunnelscript_core:work jlist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
scoreboard players remove #counter tunnelscript.vars 1
data modify storage tunnelscript_core:work jone set from storage tunnelscript_core:work jlist[0]
data remove storage tunnelscript_core:work jlist[0]
execute if score #jfirst tunnelscript.vars matches 0 run function tunnelscript_core:handlers/join_sep with storage tunnelscript_core:work
scoreboard players set #jfirst tunnelscript.vars 0
function tunnelscript_core:handlers/join_one with storage tunnelscript_core:work
function tunnelscript_core:internal/join_iter
