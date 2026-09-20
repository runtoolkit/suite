# macro: $(menu)
$execute if data storage macroengine:gui_reg menus."$(menu)" run scoreboard players set #ok macroengine.gui_const 1
$execute unless data storage macroengine:gui_reg menus."$(menu)" run tellraw @s [{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"unknown menu: $(menu)","color":"red"}]
