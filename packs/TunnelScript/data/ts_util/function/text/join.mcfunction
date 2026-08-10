# Join storage tunnelscript:in list[] (strings) into storage tunnelscript:out
# joined, separated by storage tunnelscript:in sep. Bounded by #max_actions.
data modify storage tunnelscript:out joined set value ""
data modify storage tunnelscript_core:work jlist set from storage tunnelscript:in list
data modify storage tunnelscript_core:work jsep set from storage tunnelscript:in sep
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
scoreboard players set #jfirst tunnelscript.vars 1
function tunnelscript_core:internal/join_iter
