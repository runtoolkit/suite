# macroengine:systems/flag/list_systems — List all tick channels with their current config
tellraw @s [{"text":"[DL] Tick Channels","color":"gold","bold":true}]
tellraw @s {"plain":true ,"storage":"macroengine:engine","nbt":"tick.channels","color":"yellow"}