# Extract the "value" field from the current action and run it via command block.
data modify storage tunnelscript:in cmd set from storage tunnelscript_core:work current.value
function tunnelscript_core:internal/run_block
