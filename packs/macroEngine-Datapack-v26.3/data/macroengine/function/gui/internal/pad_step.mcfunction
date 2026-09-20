# macroengine:gui :: internal/pad_step     as cart     #pi = slots still to fill; storage macroengine:gui_ctx pad
# Fills slot #pi-1, then recurses until slot 0 is done.
scoreboard players remove #pi macroengine.gui_tmp 1
execute store result storage macroengine:gui_ctx i int 1 run scoreboard players get #pi macroengine.gui_tmp
function macroengine:gui/internal/pad_slot with storage macroengine:gui_ctx
execute if score #pi macroengine.gui_tmp matches 1.. run function macroengine:gui/internal/pad_step
