# macroengine:gui :: widget/counter   as player
# storage macroengine:gui_in {obj:"score", delta:1, min:0, max:64, wrap:0b}
# wrap:0b -> clamp to [min,max]      wrap:1b -> roll over (min<->max)
function macroengine:gui/internal/counter_step with storage macroengine:gui_in
scoreboard players set @s macroengine.gui_dirty 1
