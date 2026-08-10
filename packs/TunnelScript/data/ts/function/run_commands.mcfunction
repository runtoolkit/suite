# Run many commands in one pass. Input: storage tunnelscript:in
#   { "commands": [ "say one", "say two", "say three" ] }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work clist set from storage tunnelscript:in commands
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/run_commands_iter
return 1
