# macro: $(obj) $(delta) $(min) $(max) $(wrap)
$execute unless score @s $(obj) matches ..2147483647 run scoreboard players set @s $(obj) $(min)
$scoreboard players add @s $(obj) $(delta)
# overshoot / undershoot are STRICT comparisons against max+1 / min-1 via operation on temps
$scoreboard players set #max macroengine.gui_tmp $(max)
$scoreboard players set #min macroengine.gui_tmp $(min)
$scoreboard players operation #over macroengine.gui_tmp = @s $(obj)
scoreboard players operation #over macroengine.gui_tmp -= #max macroengine.gui_tmp
scoreboard players operation #under macroengine.gui_tmp = #min macroengine.gui_tmp
$scoreboard players operation #under macroengine.gui_tmp -= @s $(obj)
# over > 0  -> value > max ; under > 0 -> value < min
$execute if score #over macroengine.gui_tmp matches 1.. run scoreboard players set @s $(obj) $(max)
$execute if score #under macroengine.gui_tmp matches 1.. run scoreboard players set @s $(obj) $(min)
# wrap: overshoot -> min, undershoot -> max
$execute if data storage macroengine:gui_in {wrap:1b} if score #over macroengine.gui_tmp matches 1.. run scoreboard players set @s $(obj) $(min)
$execute if data storage macroengine:gui_in {wrap:1b} if score #under macroengine.gui_tmp matches 1.. run scoreboard players set @s $(obj) $(max)
