# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/freeze/internal/tick [INTERNAL — runs via on_tick]
# Hooked into #macroengine:events/on_tick (called every game tick).
#
# Early-exit if no frozen players exist — zero cost when the
# freeze system is idle.
#
# For each anchor stand: switch execution position to the stand,
# then delegate to anchor_tp which identifies and teleports the
# matching frozen player back to that position.
# ─────────────────────────────────────────────────────────────────

# Fast exit — no frozen players, nothing to do
execute unless entity @a[tag=macroengine.frozen] run return 0

# Iterate anchor stands and teleport their linked players back
execute as @e[tag=macroengine.freeze_anchor] at @s run function macroengine:core/internal/api/cmd/freeze/anchor_tp
