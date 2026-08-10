# Stop recording. Existing entries are kept.
scoreboard players set #log_enabled tunnelscript.vars 0
tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"command log OFF","color":"yellow"}]
