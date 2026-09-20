# macroengine:gui :: cond/t_item_count    storage macroengine:gui_cond {item, [min]}
execute unless data storage macroengine:gui_cond item run return 0
execute unless data storage macroengine:gui_cond min run data modify storage macroengine:gui_cond min set value 1
function macroengine:gui/cond/t_item_count_do with storage macroengine:gui_cond
