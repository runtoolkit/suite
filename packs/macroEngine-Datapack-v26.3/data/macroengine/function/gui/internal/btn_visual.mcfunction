# macro: $(id)     as player     (called by widget/button with storage macroengine:gui_w)
# Swaps macroengine:gui/w item for the definition's locked_item when its cond currently fails.
data remove storage macroengine:gui_btn cur
$data modify storage macroengine:gui_btn cur set from storage macroengine:gui_btn defs."$(id)"
execute unless data storage macroengine:gui_btn cur.cond unless data storage macroengine:gui_btn cur.cost run return 0
function macroengine:gui/internal/btn_gate
execute if score #cond macroengine.gui_tmp matches 1 run return 0
data modify storage macroengine:gui_w item set value "minecraft:barrier"
execute if data storage macroengine:gui_btn cur.locked_item run data modify storage macroengine:gui_w item set from storage macroengine:gui_btn cur.locked_item
