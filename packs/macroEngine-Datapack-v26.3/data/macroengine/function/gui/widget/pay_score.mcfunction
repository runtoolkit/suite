# macroengine:gui :: widget/pay_score   as player   storage macroengine:gui_in {obj:"coins", amount:50}
function macroengine:gui/internal/pay_score with storage macroengine:gui_in
return run scoreboard players get #paid macroengine.gui_tmp
