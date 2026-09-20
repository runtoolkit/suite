# macroengine:gui :: internal/btn_afford_item     as player
# Reuses the item_count condition, which does not count the clicked widget item (see cond/t_item_count_do).
scoreboard players set #cond macroengine.gui_tmp 0
function macroengine:gui/internal/clear_cond
data modify storage macroengine:gui_cond item set from storage macroengine:gui_btn cur.cost.item
data modify storage macroengine:gui_cond min set from storage macroengine:gui_btn cur.cost.count
function macroengine:gui/cond/t_item_count_do with storage macroengine:gui_cond
function macroengine:gui/internal/clear_cond
