# macro: $(obj) $(amount)
scoreboard players set #paid macroengine.gui_tmp 0
$execute if score @s $(obj) matches $(amount).. run scoreboard players set #paid macroengine.gui_tmp 1
$execute if score #paid macroengine.gui_tmp matches 1 run scoreboard players remove @s $(obj) $(amount)
