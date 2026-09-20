# macroengine:gui :: widget/pay_item   as player   storage macroengine:gui_in {item:"minecraft:diamond", count:3}
# Result: 1 paid / 0 not enough
function macroengine:gui/internal/pay_item with storage macroengine:gui_in
return run scoreboard players get #paid macroengine.gui_tmp
