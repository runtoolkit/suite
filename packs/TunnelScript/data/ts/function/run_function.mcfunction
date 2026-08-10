# Run a single function with an argument source.
# Input: storage tunnelscript:in
#   { "func": "namespace:path", "type": "storage", "val": "namespace:args" }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
function tunnelscript_core:handlers/run_function with storage tunnelscript:in
return 1
