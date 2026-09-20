# macro: $(slot) $(cell) $(item) $(id) $(name)
# absolute slot = slot + cell  (done by scoreboard, then draw)
$scoreboard players set #abs macroengine.gui_tmp $(slot)
$scoreboard players add #abs macroengine.gui_tmp $(cell)
execute store result storage macroengine:gui_pg abs int 1 run scoreboard players get #abs macroengine.gui_tmp
$data modify storage macroengine:gui_w item set value "$(item)"
$data modify storage macroengine:gui_w id set value "$(id)_$(cell)"
data modify storage macroengine:gui_w type set value "progress"
$data modify storage macroengine:gui_w name set value '$(name)'
data modify storage macroengine:gui_w slot set from storage macroengine:gui_pg abs
data modify storage macroengine:gui_w lore set value []
function macroengine:gui/widget/draw
