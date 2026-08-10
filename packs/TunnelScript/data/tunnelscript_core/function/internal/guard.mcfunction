# Cooldown gate. Returns 1 when execution is permitted, 0 while cooling down.
# A cooldown_max of 0 (or less) disables the gate entirely.
execute if score #cooldown_max tunnelscript.vars matches ..0 run return 1
execute store result score #now tunnelscript.vars run time query gametime
scoreboard players operation #elapsed tunnelscript.vars = #now tunnelscript.vars
scoreboard players operation #elapsed tunnelscript.vars -= #last_run tunnelscript.vars
execute if score #elapsed tunnelscript.vars < #cooldown_max tunnelscript.vars run return 0
scoreboard players operation #last_run tunnelscript.vars = #now tunnelscript.vars
return 1
