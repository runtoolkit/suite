# Run an action list after a delay (single shot). Input: storage tunnelscript:in
#   { "delay": "20t", "actions": [ {"type":"cmd","value":"say later"} ] }
# "delay" is a /schedule time like "20t", "5s" or "1d". Only the most recently
# scheduled list is kept. This is one-shot -- it does not repeat.
data modify storage tunnelscript_core:later actions set from storage tunnelscript:in actions
function tunnelscript_core:handlers/run_after with storage tunnelscript:in
