# macroengine:gui :: cond/comp_run     as player     #cmode 0 = all / 1 = any, #cacc = starting value
# Walks the list macroengine:gui/cond of, loading each element into macroengine:gui/cond and running cond/check on it.
# One level only: an element that is itself all/any is not evaluated and counts as FAILED. A missing
# `of` fails (return 0, `not` is not applied). Result in #cond macroengine.gui_tmp, also returned.
execute store success score #cnot macroengine.gui_tmp if data storage macroengine:gui_cond {not:1b}
data remove storage macroengine:gui_cnd items
data modify storage macroengine:gui_cnd items set from storage macroengine:gui_cond of
execute unless data storage macroengine:gui_cnd items run return 0
execute store result score #cn macroengine.gui_tmp run data get storage macroengine:gui_cnd items
scoreboard players set #ci macroengine.gui_tmp 0
function macroengine:gui/cond/comp_step
scoreboard players operation #cond macroengine.gui_tmp = #cacc macroengine.gui_tmp
execute if score #cnot macroengine.gui_tmp matches 1 run function macroengine:gui/cond/negate
data remove storage macroengine:gui_cnd items
data remove storage macroengine:gui_cnd cur
function macroengine:gui/internal/clear_cond
return run scoreboard players get #cond macroengine.gui_tmp
