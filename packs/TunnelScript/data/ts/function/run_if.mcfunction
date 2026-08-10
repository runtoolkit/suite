# Run an action list only if a condition holds. Input: storage tunnelscript:in
#   { "if": "score @s ts.x matches 1..", "actions": [ {"type":"cmd","value":"say ok"} ] }
# "if" is the text you would put after "execute if" (use "unless ..." to negate).
function tunnelscript_core:handlers/run_if with storage tunnelscript:in
