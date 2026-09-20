# macroengine:gui :: cond/t_score    storage macroengine:gui_cond {obj, [min], [max]}
execute unless data storage macroengine:gui_cond obj run return 0
execute unless data storage macroengine:gui_cond min run data modify storage macroengine:gui_cond min set value -2147483648
execute unless data storage macroengine:gui_cond max run data modify storage macroengine:gui_cond max set value 2147483647
function macroengine:gui/cond/t_score_do with storage macroengine:gui_cond
