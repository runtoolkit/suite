# macroengine:gui :: internal/meter_hit
# macro: $(id) $(c) $(obj) $(max)     as player   (called by internal/meter_probe_loop)
# Non-destructive presence test for cell $(c) of meter $(id) (same trick as widget/probe). On a
# hit, sets $(obj) to the cell's scaled value using score #mw macroengine.gui_tmp (width, set by
# widget/meter_probe) and marks the menu dirty for redraw.
$execute store result score #mhit macroengine.gui_tmp run clear @s *[custom_data~{macroengine:{gui:{w:1b,id:"$(id)_$(c)"}}}] 0
execute unless score #mhit macroengine.gui_tmp matches 1.. run return 0
$scoreboard players set #mval macroengine.gui_tmp $(c)
scoreboard players add #mval macroengine.gui_tmp 1
$scoreboard players set #mmax macroengine.gui_tmp $(max)
scoreboard players operation #mval macroengine.gui_tmp *= #mmax macroengine.gui_tmp
scoreboard players operation #mval macroengine.gui_tmp /= #mw macroengine.gui_tmp
$scoreboard players operation @s $(obj) = #mval macroengine.gui_tmp
scoreboard players set @s macroengine.gui_dirty 1
