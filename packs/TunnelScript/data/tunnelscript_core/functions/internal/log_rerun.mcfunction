# Copy the newest log entry back into the runner input and run it.
# The cooldown guard still applies, exactly as for a normal ts:run_command.
data modify storage tunnelscript:in cmd set from storage tunnelscript:log entries[-1]
function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 1 run function tunnelscript_core:internal/run_block
