# Pause minecart input scanning and queue execution.
scoreboard players set #input_paused tunnelscript.vars 1
tellraw @s [{"text":"[TunnelScript] Input paused","color":"yellow"}]
