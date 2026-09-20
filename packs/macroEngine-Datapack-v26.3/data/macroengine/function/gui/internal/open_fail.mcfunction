# macroengine:gui :: internal/open_fail     as player, at player     (called by api/open)
# The summon produced no usable cart: unknown entity id, or an entity that is not in the
# entity type tag #macroengine:gui/container (then the cart could never be bound to its owner and would
# live forever). Remove it and roll the half-opened state back.
execute store result storage macroengine:gui_ctx uid int 1 run scoreboard players get @s macroengine.gui_uid
function macroengine:gui/internal/cont_unbind with storage macroengine:gui_ctx
kill @e[tag=macroengine.gui_new,distance=..1]
scoreboard players reset @s macroengine.gui_uid
scoreboard players reset @s macroengine.gui_slots
function macroengine:gui/internal/clear_tmp
tellraw @s [{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"could not open the menu: its container entity was not created or is not in #macroengine:gui/container","color":"red"}]
scoreboard players set #ok macroengine.gui_const 0
return 0
