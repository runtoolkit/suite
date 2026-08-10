# Public entry point. Processes a typed action list once (cooldown gated).
# Input: storage tunnelscript:in
#   { "actions": [
#       { "type": "cmd",           "value": "say hello" },
#       { "type": "function",      "func": "namespace:path" },
#       { "type": "function_with", "func": "namespace:path", "with": "storage", "val": "namespace:args" },
#       { "type": "give",          "value": "..." }   // any handler name works as a type
#   ] }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work actions set from storage tunnelscript:in actions
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/iterate
return 1
