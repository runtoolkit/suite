# Resolve the command alias, then run it via the command block.
execute if data storage tunnelscript:in command run data modify storage tunnelscript:in cmd set from storage tunnelscript:in command
function tunnelscript_core:internal/run_block
