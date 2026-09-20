# macroengine:gui :: internal/btn_afford     as player     reads storage macroengine:gui_btn cur.cost
#   cost:{obj:"coins", amount:5}                    score cost
#   cost:{item:"minecraft:diamond", [count:3]}      item cost (count defaults to 1)
# Result in #cond macroengine.gui_tmp (1 = enough). Does not charge.
scoreboard players set #cond macroengine.gui_tmp 1
execute unless data storage macroengine:gui_btn cur.cost.count run data modify storage macroengine:gui_btn cur.cost.count set value 1
execute if data storage macroengine:gui_btn cur.cost.obj run function macroengine:gui/internal/btn_afford_score with storage macroengine:gui_btn cur.cost
execute if data storage macroengine:gui_btn cur.cost.item run function macroengine:gui/internal/btn_afford_item
