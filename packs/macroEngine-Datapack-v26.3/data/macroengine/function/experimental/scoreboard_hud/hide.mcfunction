# macroengine:experimental/scoreboard_hud/hide [INTERNAL]
scoreboard objectives setdisplay sidebar
scoreboard players set #exp_hud_on macroengine.tmp 0
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"scoreboard HUD → ","color":"gray"},{"text":"off","color":"red"}]
