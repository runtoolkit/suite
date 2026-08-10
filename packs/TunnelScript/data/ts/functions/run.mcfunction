# Run a typed action list (cmd/command types only). Input:
#   { "actions": [
#       { "type": "cmd", "value": "say hello" },
#       { "type": "command", "value": "tp @p 0 100 0" }
#   ] }
# Other action types (function, function_with, give, etc.) are silently
# skipped on the 1.19.2 build because dynamic dispatch requires macros.
function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 1 run function tunnelscript_core:internal/do_run
