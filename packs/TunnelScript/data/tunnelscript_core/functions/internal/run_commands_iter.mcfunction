# Consume clist[] one command at a time and run it through the command block.
# Bounded by #counter (max_actions); finite recursion, never an auto-loop.
execute if data storage tunnelscript_core:work clist[0] if score #counter tunnelscript.vars matches 1.. run function tunnelscript_core:internal/run_commands_step
