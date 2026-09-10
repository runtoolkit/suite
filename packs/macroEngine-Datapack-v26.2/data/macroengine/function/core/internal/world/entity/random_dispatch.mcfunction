# ─────────────────────────────────────────────────────────────────
# macroengine:world/entity/internal/random_dispatch  [INTERNAL — MACRO]
# Called with "with storage macroengine:engine _rnd".
#
# Rolls /random value 0..$(max) to pick a uniform random index,
# then runs the target function as the entity whose macroengine.rnd_idx
# matches the rolled value.
#
# MACRO ARGS (from macroengine:engine _rnd compound):
#   $(max)  → count - 1  (upper bound for random value, inclusive)
#   $(func) → function to dispatch
#   $(type) → entity type filter (same as outer call)
#   $(tag)  → entity tag filter  (same as outer call)
# ─────────────────────────────────────────────────────────────────

# Roll a random integer in [0, max] using the 1.20.2+ /random command
$execute store result score $rnd_pick macroengine.tmp run random value 0..$(max)

# Dispatch: run func as the entity whose index was rolled
$data modify storage macroengine:engine _dispatch.func set value "$(func)"
$execute as @e[type=$(type),tag=$(tag)] if score @s macroengine.rnd_idx = $rnd_pick macroengine.tmp at @s run function #macroengine:internal/dispatch
