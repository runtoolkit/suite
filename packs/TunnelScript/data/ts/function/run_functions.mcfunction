# Run many functions (no arguments) in one pass. Input: storage tunnelscript:in
#   { "functions": [ "ns:a", "ns:b", "ns:c" ] }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work flist set from storage tunnelscript:in functions
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/run_functions_iter
return 1
