# macroengine:gui :: internal/reset_cd     as player     (reward of the advancement macroengine:gui/interact_cart)
# Restarts the MENU TIMEOUT (`macroengine.gui_timer`, the countdown that closes an idle menu) when the player
# interacts with (right-clicks) a gui cart. NOT the cooldown scoreboard `macroengine.gui_cd`, despite the name.
# It restores the value the menu was opened with (`macroengine.gui_tmax`, set by api/open). Clicking widgets inside
# the open GUI does NOT reset the timer any more.
# The advancement is granted only once, so it has to be revoked here or it could never fire again.
advancement revoke @s only macroengine:gui/interact_cart
execute if score @s macroengine.gui_uid matches 1.. if score @s macroengine.gui_tmax matches 1.. run scoreboard players operation @s macroengine.gui_timer = @s macroengine.gui_tmax
