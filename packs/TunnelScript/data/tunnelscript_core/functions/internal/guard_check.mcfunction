# Helper: evaluate the cooldown window using the world game time.
execute store result score #now tunnelscript.vars run time query gametime
scoreboard players operation #elapsed tunnelscript.vars = #now tunnelscript.vars
scoreboard players operation #elapsed tunnelscript.vars -= #last_run tunnelscript.vars
execute if score #elapsed tunnelscript.vars < #cooldown_max tunnelscript.vars run scoreboard players set #allowed tunnelscript.vars 0
execute if score #allowed tunnelscript.vars matches 1 run scoreboard players operation #last_run tunnelscript.vars = #now tunnelscript.vars
