# macroengine:gui :: api/refresh      as <player>
# Redraws this player's open menu from outside the gui module (another datapack, a scoreboard trigger,
# a timer...) without closing/reopening it. Before this, the only way was writing
# `macroengine.gui_dirty` by hand.
#
#   execute as <player> run function macroengine:gui/api/refresh
#
# Result: 1 = redraw scheduled, 0 = this player has no open menu (nothing touched).
#
# The redraw happens on the player's next tick_player run (dirty is picked up there), so a
# handler may call this several times in one tick and the menu is still drawn only once.
execute unless score @s macroengine.gui_uid matches 1.. run return 0
scoreboard players set @s macroengine.gui_dirty 1
return 1
