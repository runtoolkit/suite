# Run a single command. Input: storage tunnelscript:in
#   { "command": "say hi" }   // "cmd" and "func" are accepted aliases too
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work one set value {}
execute if data storage tunnelscript:in command run data modify storage tunnelscript_core:work one.value set from storage tunnelscript:in command
execute if data storage tunnelscript:in cmd run data modify storage tunnelscript_core:work one.value set from storage tunnelscript:in cmd
execute if data storage tunnelscript:in func run data modify storage tunnelscript_core:work one.value set from storage tunnelscript:in func
function tunnelscript_core:handlers/cmd with storage tunnelscript_core:work one
return 1
