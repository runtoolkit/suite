# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/freeze/internal/remove  [INTERNAL]
# Runs AS the player being unfrozen.
#
# Copies the player's macroengine.pid to tmp, then kills every anchor
# stand whose macroengine.freeze_id matches (should always be exactly one).
# Then removes the macroengine.frozen tag so the tick function's
# early-exit check fires and no further TPs occur.
# ─────────────────────────────────────────────────────────────────

# Store this player's PID so we can match it against anchor stands
scoreboard players operation $freeze_rm macroengine.tmp = @s macroengine.pid

# Kill the matching anchor stand
execute as @e[tag=macroengine.freeze_anchor] if score @s macroengine.freeze_id = $freeze_rm macroengine.tmp run kill @s

# Unfreeze the player
tag @s remove macroengine.frozen

# Notify and play sound
playsound macroengine:ui.unfreeze master @s ~ ~ ~ 0.7 1.3
tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"translate":"macroengine.msg.unfreeze","color":"#55ff55","bold":true}]
