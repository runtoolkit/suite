# macroengine:gui :: widget/pad_cart_dyn     as cart (macroengine.gui_styled)
# Pad item and slot count come from the definition kept by owner uid (internal/cont_bind).
execute store result storage macroengine:gui_ctx uid int 1 run scoreboard players get @s macroengine.gui_uid
data remove storage macroengine:gui_ctx pad
function macroengine:gui/internal/pad_load with storage macroengine:gui_ctx
execute unless data storage macroengine:gui_ctx pad run return 0
scoreboard players operation #pi macroengine.gui_tmp = @s macroengine.gui_slots
function macroengine:gui/internal/pad_step
data remove storage macroengine:gui_ctx pad
data remove storage macroengine:gui_ctx uid
data remove storage macroengine:gui_ctx i
