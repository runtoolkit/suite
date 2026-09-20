# macroengine:gui :: internal/btn_pay     as player     reads storage macroengine:gui_btn cur.cost
# Charges the cost through the existing helpers. Result in #paid macroengine.gui_tmp (1 = paid, 0 = not enough).
execute unless data storage macroengine:gui_btn cur.cost.count run data modify storage macroengine:gui_btn cur.cost.count set value 1
execute if data storage macroengine:gui_btn cur.cost.obj run function macroengine:gui/internal/pay_score with storage macroengine:gui_btn cur.cost
execute if data storage macroengine:gui_btn cur.cost.item run function macroengine:gui/internal/btn_pay_item
