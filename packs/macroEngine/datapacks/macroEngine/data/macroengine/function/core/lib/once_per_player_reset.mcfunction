# ─────────────────────────────────────────────────────────────────
# macroengine:core/lib/once_per_player_reset
# Deletes the once_per_player record — function can run again.
#  Girdi : $(player), $(key)
# ─────────────────────────────────────────────────────────────────

$data remove storage macroengine:engine once_per_player.$(player).$(key)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/once_per_player_reset ","color":"aqua"},{"text":"$(player):$(key) reset","color":"yellow"}]
