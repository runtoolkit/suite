# macro: $(item) $(count)
scoreboard players set #paid macroengine.gui_tmp 0
$execute store result score #have macroengine.gui_tmp run clear @s $(item) 0
$execute if score #have macroengine.gui_tmp matches $(count).. run scoreboard players set #paid macroengine.gui_tmp 1
$execute if score #paid macroengine.gui_tmp matches 1 run clear @s $(item) $(count)
