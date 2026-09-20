# macroengine:gui :: widget/meter_draw    as player   storage macroengine:gui_w = {slot, id}
# Call as:
#   data merge storage macroengine:gui_w {slot:20, id:"ns:vol"}
#   function macroengine:gui/widget/meter_draw with storage macroengine:gui_w
#
# `id` must be registered once, in your #macroengine:gui/register listener (like widget/button's defs):
#   data modify storage macroengine:gui_mtr defs."ns:vol" set value {obj:"volume", width:5, max:5,
#     full:"minecraft:lime_dye", empty:"minecraft:gray_dye", name:{text:"Volume",italic:false}}
#
# Draws `width` clickable cells starting at `slot`, filled up to the live `obj` score (same
# scaling as widget/progress: filled = obj * width / max). Cell i's clickable id is "<id>_i" --
# click it with widget/meter_probe (ONE registration per meter, not per cell).
function macroengine:gui/internal/clear_mtr
$data modify storage macroengine:gui_mtr cur set from storage macroengine:gui_mtr defs."$(id)"
execute unless data storage macroengine:gui_mtr cur run return 0
data modify storage macroengine:gui_mtr obj set from storage macroengine:gui_mtr cur.obj
data modify storage macroengine:gui_mtr max set from storage macroengine:gui_mtr cur.max
data modify storage macroengine:gui_mtr width set from storage macroengine:gui_mtr cur.width

function macroengine:gui/internal/progress_calc with storage macroengine:gui_mtr

data modify storage macroengine:gui_pg cur set value 0
data modify storage macroengine:gui_pg slot set from storage macroengine:gui_w slot
data modify storage macroengine:gui_pg width set from storage macroengine:gui_mtr cur.width
data modify storage macroengine:gui_pg full set from storage macroengine:gui_mtr cur.full
data modify storage macroengine:gui_pg empty set from storage macroengine:gui_mtr cur.empty
data modify storage macroengine:gui_pg id set from storage macroengine:gui_w id
data modify storage macroengine:gui_pg name set from storage macroengine:gui_mtr cur.name
function macroengine:gui/internal/meter_loop
