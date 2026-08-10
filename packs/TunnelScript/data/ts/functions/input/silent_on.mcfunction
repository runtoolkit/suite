# Disable input capture/execution chat messages.
scoreboard players set #input_silent tunnelscript.vars 1
tellraw @s [{"text":"[TunnelScript] Input silent mode on","color":"yellow"}]
