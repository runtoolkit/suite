# macroengine:gui :: cond/t_level    storage macroengine:gui_cond {[min], [max]}
# XP level (the number shown above the hotbar), NOT a scoreboard objective -- `score` cannot read it.
# At least one of min/max should be given; with neither, any level passes (min defaults to 0).
# Same two-open-ended-ranges rule as t_score_do (see README "Validation status").
execute unless data storage macroengine:gui_cond min run data modify storage macroengine:gui_cond min set value 0
execute unless data storage macroengine:gui_cond max run data modify storage macroengine:gui_cond max set value 2147483647
function macroengine:gui/cond/t_level_do with storage macroengine:gui_cond
