# macroengine:gui :: widget/radio   as player
# storage macroengine:gui_in {obj:"mode", value:2}
# Direct-assign generalization of widget/toggle for objectives with more than two states: each
# option in the group calls this with its own literal `value` (menu code decides which slot maps
# to which value, exactly like widget/toggle / widget/cycle -- no separate defs registry, unlike
# widget/button or widget/meter).
function macroengine:gui/internal/radio_set with storage macroengine:gui_in
scoreboard players set @s macroengine.gui_dirty 1
