# macroengine:experimental/scoreboard_hud/show [INTERNAL]
scoreboard objectives setdisplay sidebar macroengine.exp_combat_timer
scoreboard players set #exp_hud_on macroengine.tmp 1
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"scoreboard HUD → ","color":"gray"},{"text":"on","color":"green"}]
