# macroengine:gui :: widget/draw    as player   (cart of this player is resolved by uid)
# storage macroengine:gui_w = {slot, item, id, type, name, lore}
scoreboard players operation #uid macroengine.gui_tmp = @s macroengine.gui_uid
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart] if score @s macroengine.gui_uid = #uid macroengine.gui_tmp run function macroengine:gui/widget/draw_on_cart with storage macroengine:gui_w
