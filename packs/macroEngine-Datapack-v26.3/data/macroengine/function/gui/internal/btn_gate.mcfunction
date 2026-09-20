# macroengine:gui :: internal/btn_gate     as player     reads storage macroengine:gui_btn cur
# Result: #cond macroengine.gui_tmp = 1 when the button's cond passes AND its cost is affordable, else 0.
# Nothing is charged here (used when drawing, to decide the locked look).
function macroengine:gui/internal/btn_cond
execute if score #cond macroengine.gui_tmp matches 0 run return 0
execute if data storage macroengine:gui_btn cur.cost run function macroengine:gui/internal/btn_afford
