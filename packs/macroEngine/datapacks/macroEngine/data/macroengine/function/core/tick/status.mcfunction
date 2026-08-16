# macroengine:core/tick/status — Show tick engine diagnostics
tellraw @s [{"text":"","extra":[{"text":"══ DL Tick Engine v2 ══","color":"gold","bold":true}]}]
tellraw @s [{"text":" Counter ","color":"gray"},{"score":{"name":"#tick_ctr","objective":"macroengine.tick"},"color":"aqua"}]
tellraw @s [{"text":" Paused ","color":"gray"},{"plain":true ,"storage":"macroengine:engine","nbt":"tick.paused","color":"red"}]
tellraw @s [{"text":" Channels","color":"gray"}]
tellraw @s {"plain":true ,"storage":"macroengine:engine","nbt":"tick.channels","color":"yellow"}