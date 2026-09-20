# macroengine:gui :: internal/sweep_keep   as player with an open menu
scoreboard players operation #uid macroengine.gui_tmp = @s macroengine.gui_uid
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart,tag=macroengine.gui_orphan] if score @s macroengine.gui_uid = #uid macroengine.gui_tmp run tag @s remove macroengine.gui_orphan
