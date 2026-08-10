# Restore the default configuration (cooldown off, 256 actions per run).
scoreboard players set #cooldown_max tunnelscript.vars 0
scoreboard players set #max_actions tunnelscript.vars 256
tellraw @s {"text":"[TunnelScript] configuration reset to defaults","color":"green"}
