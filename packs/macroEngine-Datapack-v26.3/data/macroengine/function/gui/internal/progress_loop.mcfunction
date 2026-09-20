# recursive: one cell per iteration
execute if score #left macroengine.gui_tmp matches ..0 run return 0
# choose item for this cell: full if #i < #f
scoreboard players operation #d macroengine.gui_tmp = #f macroengine.gui_tmp
scoreboard players operation #d macroengine.gui_tmp -= #i macroengine.gui_tmp
data modify storage macroengine:gui_pg item set from storage macroengine:gui_pg empty
execute if score #d macroengine.gui_tmp matches 1.. run data modify storage macroengine:gui_pg item set from storage macroengine:gui_pg full
# slot = base + i
execute store result storage macroengine:gui_pg cell int 1 run scoreboard players get #i macroengine.gui_tmp
function macroengine:gui/internal/progress_slot with storage macroengine:gui_pg
scoreboard players add #i macroengine.gui_tmp 1
scoreboard players remove #left macroengine.gui_tmp 1
function macroengine:gui/internal/progress_loop
