# macroengine:gui :: widget/pad     as player  - fill ALL slots of the cart with locked panes; draw widgets AFTER this
# Plain chest_minecart (27 slots, gray): the static widget/pad_cart. Anything else the container registry
# describes differently (pad item, slot count: hopper_minecart, ender_chest, your own) is tagged
# macroengine.gui_styled at summon and filled by widget/pad_cart_dyn from its registry definition.
scoreboard players operation #uid macroengine.gui_tmp = @s macroengine.gui_uid
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart,tag=!macroengine.gui_styled] if score @s macroengine.gui_uid = #uid macroengine.gui_tmp run function macroengine:gui/widget/pad_cart
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart,tag=macroengine.gui_styled] if score @s macroengine.gui_uid = #uid macroengine.gui_tmp run function macroengine:gui/widget/pad_cart_dyn
