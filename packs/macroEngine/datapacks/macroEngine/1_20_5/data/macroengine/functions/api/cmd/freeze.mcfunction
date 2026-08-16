
# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/freeze
# Freezes a player in place using an invisible marker armor stand.
# Every tick the frozen player is teleported back to the stand's
# position, preventing any movement. This is the only reliable
# vanilla method — player NBT is read-only so FrozenTicks cannot
# be set, and Slowness 255 alone does not stop client-side movement.
#
# On freeze: a marker armor stand is summoned at the player's feet,
# the player's macroengine.pid is copied to the stand's macroengine.freeze_id,
# and the player receives the macroengine.frozen tag.
#
# The per-tick teleport back is handled by:
# macroengine:api/cmd/freeze/internal/tick (hooked via #macroengine:events/on_tick)
#
# Use macroengine:api/cmd/unfreeze to release.
#
# INPUT : $(player) → exact player name
#
# EXAMPLE:
# function macroengine:api/cmd/freeze {player:"Steve"}
# ─────────────────────────────────────────────────────────────────

$execute as @a[name=$(player),tag=!macroengine.frozen,limit=1] run function macroengine:core/internal/api/cmd/freeze/apply
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/freeze ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"translate":"macroengine.msg.freeze","color":"#00aaff","bold":true}]
