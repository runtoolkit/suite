# macro: $(obj)
$execute unless score @s $(obj) matches 0.. run scoreboard players set @s $(obj) 0
$execute store success score #flip macroengine.gui_tmp if score @s $(obj) matches 0
$scoreboard players operation @s $(obj) = #flip macroengine.gui_tmp
