# macroengine:gui :: widget/progress   as player
# storage macroengine:gui_w = {obj:"score", slot:9, width:5, max:10, full:"minecraft:lime_stained_glass_pane",
#                     empty:"minecraft:gray_stained_glass_pane", id:"bar1", name:{text:" "}}
# Draws `width` cells starting at `slot`. Cell i (0-based) is full when i < filled.
function macroengine:gui/internal/progress_calc with storage macroengine:gui_w
# working copy
data modify storage macroengine:gui_pg cur set value 0
data modify storage macroengine:gui_pg slot set from storage macroengine:gui_w slot
data modify storage macroengine:gui_pg width set from storage macroengine:gui_w width
data modify storage macroengine:gui_pg full set from storage macroengine:gui_w full
data modify storage macroengine:gui_pg empty set from storage macroengine:gui_w empty
data modify storage macroengine:gui_pg id set from storage macroengine:gui_w id
data modify storage macroengine:gui_pg name set from storage macroengine:gui_w name
function macroengine:gui/internal/progress_loop
