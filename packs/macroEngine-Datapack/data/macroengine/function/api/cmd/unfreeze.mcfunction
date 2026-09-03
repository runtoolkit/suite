
# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/unfreeze
# Releases a player previously frozen by macroengine:api/cmd/freeze.
#
# 1. Finds the frozen player's macroengine.pid.
# 2. Kills the anchor armor stand whose macroengine.freeze_id matches.
# 3. Removes the macroengine.frozen tag so the tick function stops
#    teleporting them.
# 4. Plays the unfreeze sound and notifies the player.
#
# INPUT : $(player) → exact player name
#
# EXAMPLE:
#   function macroengine:api/cmd/unfreeze {player:"Steve"}
# ─────────────────────────────────────────────────────────────────

$execute as @a[name=$(player),tag=macroengine.frozen,limit=1] run function macroengine:core/internal/api/cmd/freeze/remove
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/unfreeze ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"translate":"macroengine.msg.unfreeze","color":"#55ff55","bold":true}]
