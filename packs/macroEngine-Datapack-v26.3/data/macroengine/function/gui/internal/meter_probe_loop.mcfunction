# macroengine:gui :: internal/meter_probe_loop   (recursive)
# Reads storage macroengine:gui_mtr {id, obj, max} and score #mc/#mw macroengine.gui_tmp (current cell / width),
# set by widget/meter_probe. Stops as soon as a cell hits (internal/meter_hit sets #mhit).
execute if score #mc macroengine.gui_tmp >= #mw macroengine.gui_tmp run return 0
execute store result storage macroengine:gui_mtr c int 1 run scoreboard players get #mc macroengine.gui_tmp
function macroengine:gui/internal/meter_hit with storage macroengine:gui_mtr
execute if score #mhit macroengine.gui_tmp matches 1 run return 0
scoreboard players add #mc macroengine.gui_tmp 1
function macroengine:gui/internal/meter_probe_loop
