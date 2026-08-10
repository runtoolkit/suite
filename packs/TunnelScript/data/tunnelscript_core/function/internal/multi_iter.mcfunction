# Applies storage tunnelscript_core:work keyword to every entry of vlist[] once.
execute unless data storage tunnelscript_core:work vlist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work mone set value {}
data modify storage tunnelscript_core:work mone.keyword set from storage tunnelscript_core:work keyword
data modify storage tunnelscript_core:work mone.arg set from storage tunnelscript_core:work vlist[0]
data remove storage tunnelscript_core:work vlist[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:handlers/multi_one with storage tunnelscript_core:work mone
function tunnelscript_core:internal/multi_iter
