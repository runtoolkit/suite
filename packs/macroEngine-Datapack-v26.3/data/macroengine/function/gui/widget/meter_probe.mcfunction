# macroengine:gui :: widget/meter_probe    as player    storage macroengine:gui_p {id:"ns:id"}
# ONE registration per meter (not per cell!) in your #macroengine:gui/probe listener:
#   data merge storage macroengine:gui_p {id:"ns:vol"}
#   function macroengine:gui/widget/meter_probe with storage macroengine:gui_p
#
# Tests each of the meter's `width` cells in turn; on a hit, sets the def's `obj` to the clicked
# cell's scaled value (cell 0..width-1 -> (cell+1)*max/width, floor) and marks the redraw dirty.
function macroengine:gui/internal/clear_mtr
$data modify storage macroengine:gui_mtr cur set from storage macroengine:gui_mtr defs."$(id)"
execute unless data storage macroengine:gui_mtr cur run return 0
data modify storage macroengine:gui_mtr obj set from storage macroengine:gui_mtr cur.obj
data modify storage macroengine:gui_mtr max set from storage macroengine:gui_mtr cur.max
execute store result score #mw macroengine.gui_tmp run data get storage macroengine:gui_mtr cur.width
data modify storage macroengine:gui_mtr id set from storage macroengine:gui_p id
scoreboard players set #mc macroengine.gui_tmp 0
function macroengine:gui/internal/meter_probe_loop
