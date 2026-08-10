# Run an action list as/at selected entities. Input: storage tunnelscript:in
#   { "selector": "@a", "actions": [ {"type":"cmd","value":"effect give @s glowing"} ] }
# Each matched entity runs the same action list once (as @s, at its position).
function tunnelscript_core:handlers/run_as with storage tunnelscript:in
