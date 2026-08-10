# Cooldown gate. Sets #allowed (tunnelscript.vars) to 1 when allowed, else 0.
# A cooldown_max of 0 or less disables the gate.
scoreboard players set #allowed tunnelscript.vars 1
execute if score #cooldown_max tunnelscript.vars matches 1.. run function tunnelscript_core:internal/guard_check
