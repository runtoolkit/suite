# macroengine:gui :: api/close        as <player>
# Only touches the cart owned by THIS player (uid match), and only widget items in the inventory.
scoreboard players operation #uid macroengine.gui_tmp = @s macroengine.gui_uid
execute store result storage macroengine:gui_ctx uid int 1 run scoreboard players get @s macroengine.gui_uid
function macroengine:gui/internal/cont_unbind with storage macroengine:gui_ctx
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart] if score @s macroengine.gui_uid = #uid macroengine.gui_tmp run function macroengine:gui/internal/dispose_cart

function macroengine:gui/internal/safe_clear

scoreboard players reset @s macroengine.gui_timer
scoreboard players reset @s macroengine.gui_tmax
scoreboard players reset @s macroengine.gui_page
scoreboard players reset @s macroengine.gui_dirty
scoreboard players reset @s macroengine.gui_uid
scoreboard players reset @s macroengine.gui_slots
scoreboard players reset @s macroengine.gui_click
function #macroengine:gui/clear_tags
function macroengine:gui/internal/cleanup_player

# hook: menu packs can clean up their own state here. Runs AFTER the cart is gone and this
# player's gui scores are reset, so a listener must NOT call macroengine:gui/api/open / refresh from
# here expecting the old menu to exist. Same trust model as #macroengine:gui/clear_tags.
function #macroengine:gui/on_close
