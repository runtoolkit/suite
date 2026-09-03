# macroengine:systems/flag/list_systems — List all tick systems with their current on/off state
tellraw @s [{"text":"[DL] Tick Systems","color":"gold","bold":true}]
tellraw @s [{"text":"time: ","color":"gray"},{"score":{"name":"#sys_time","objective":"macroengine.tick_flags"},"color":"yellow"}]
tellraw @s [{"text":"player: ","color":"gray"},{"score":{"name":"#sys_player","objective":"macroengine.tick_flags"},"color":"yellow"}]
tellraw @s [{"text":"queue: ","color":"gray"},{"score":{"name":"#sys_queue","objective":"macroengine.tick_flags"},"color":"yellow"}]
tellraw @s [{"text":"hud: ","color":"gray"},{"score":{"name":"#sys_hud","objective":"macroengine.tick_flags"},"color":"yellow"}]
tellraw @s [{"text":"admin: ","color":"gray"},{"score":{"name":"#sys_admin","objective":"macroengine.tick_flags"},"color":"yellow"}]
