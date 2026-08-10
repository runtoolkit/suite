# Run "clone" once per argument string. Input: storage tunnelscript:in
#   { "values": [ "<args>", "<args>" ] }
# Example arg for give: "@p minecraft:diamond 64"
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work keyword set value "clone"
data modify storage tunnelscript_core:work vlist set from storage tunnelscript:in values
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/multi_iter
return 1
