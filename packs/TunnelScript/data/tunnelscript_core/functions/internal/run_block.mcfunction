# Run the command string at storage tunnelscript:in cmd via a command block.
# 1.19.2 has no macros, so this is how a runtime-built command gets executed.
# Dry-run is checked here, so every caller that reaches the runner
# (ts:run, ts:run_command, ts:run_commands, ts:batch/run and the minecart
# input queue) is covered by one switch.
execute if score #dryrun tunnelscript.vars matches 1.. run function tunnelscript_core:internal/run_block_preview
execute unless score #dryrun tunnelscript.vars matches 1.. run function tunnelscript_core:internal/run_block_exec
