# Bounded iterator over actions[]. Stops when empty or counter exhausted.
execute if data storage tunnelscript_core:work actions[0] if score #counter tunnelscript.vars matches 1.. run function tunnelscript_core:internal/run_step
