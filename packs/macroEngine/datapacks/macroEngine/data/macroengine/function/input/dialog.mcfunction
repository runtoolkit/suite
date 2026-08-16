# ======================================================================================
# macroengine:input/dialog
# ======================================================================================
#
# TRIGGERED BY: #macroengine:input/dialog function tag
#
# PURPOSE:
#   Opens macroengine:input_prompt dialog for @s (must be run 'as' a player,
#   e.g. 'execute as <player> run function macroengine:input/dialog', or bound
#   to a right-click/other trigger by the caller). Submitted text lands in
#   macroengine:input_prompt's action, which macro-calls
#   macroengine:input/private/dialog_capture — capture only, no execution.
#
# ASSUMPTION FLAGGED — CONFIRM WITH LEGENDS11:
#   This function assumes the caller decides WHEN to open the dialog
#   (e.g. right-click on an item, a command, an advancement). It is NOT
#   wired to any automatic trigger itself — I did not invent one since
#   none was specified.
# ======================================================================================

execute if entity @s[type=minecraft:player] run dialog show @s macroengine:input_prompt
execute unless entity @s[type=minecraft:player] run return fail
