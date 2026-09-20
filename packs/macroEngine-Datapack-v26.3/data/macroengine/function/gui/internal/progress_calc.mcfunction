# macro: $(obj) $(max) $(width)
# filled = score * width / max   (integer division, floor), clamped to [0,width]
$scoreboard players operation #f macroengine.gui_tmp = @s $(obj)
$scoreboard players set #w macroengine.gui_tmp $(width)
$scoreboard players set #m macroengine.gui_tmp $(max)
scoreboard players operation #f macroengine.gui_tmp *= #w macroengine.gui_tmp
scoreboard players operation #f macroengine.gui_tmp /= #m macroengine.gui_tmp
execute if score #f macroengine.gui_tmp matches ..-1 run scoreboard players set #f macroengine.gui_tmp 0
scoreboard players operation #f2 macroengine.gui_tmp = #f macroengine.gui_tmp
scoreboard players operation #f2 macroengine.gui_tmp -= #w macroengine.gui_tmp
execute if score #f2 macroengine.gui_tmp matches 1.. run scoreboard players operation #f macroengine.gui_tmp = #w macroengine.gui_tmp
scoreboard players set #i macroengine.gui_tmp 0
scoreboard players operation #left macroengine.gui_tmp = #w macroengine.gui_tmp
