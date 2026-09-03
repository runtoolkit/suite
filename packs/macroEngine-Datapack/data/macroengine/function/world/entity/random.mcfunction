# ─────────────────────────────────────────────────────────────────
# macroengine:world/entity/random
# Selects ONE random entity matching the given type and tag and
# runs the given function as that entity (at its position).
# If no matching entity exists, nothing happens.
#
# Uses /random value (available since 1.20.2) to pick a random
# index, then dispatches via sequential macroengine.rnd_idx assignment.
# This gives a true uniform distribution across matching entities.
#
# INPUT : $(type) → entity type (e.g. "minecraft:zombie")
#         $(tag)  → entity tag to match
#         $(func) → function to run as the selected entity
#
# EXAMPLE:
#   function macroengine:world/entity/random {type:"minecraft:zombie",tag:"mob.active",func:"mypack:reward"}
# ─────────────────────────────────────────────────────────────────

# Step 1 — count all matching entities
scoreboard players set $rnd_n macroengine.tmp 0
$execute as @e[type=$(type),tag=$(tag)] run scoreboard players add $rnd_n macroengine.tmp 1

# No entities → nothing to do
execute if score $rnd_n macroengine.tmp matches 0 run return 0

# Step 2 — assign sequential macroengine.rnd_idx to each matching entity
#           (random_assign runs AS each entity to maintain counter state)
scoreboard players set $rnd_i macroengine.tmp 0
$execute as @e[type=$(type),tag=$(tag)] run function macroengine:core/internal/world/entity/random_assign

# Step 3 — compute max = count-1, store for the dispatch macro
scoreboard players remove $rnd_n macroengine.tmp 1
execute store result storage macroengine:engine _rnd.max int 1 run scoreboard players get $rnd_n macroengine.tmp
$data modify storage macroengine:engine _rnd.func set value "$(func)"
$data modify storage macroengine:engine _rnd.type set value "$(type)"
$data modify storage macroengine:engine _rnd.tag set value "$(tag)"

# Step 4 — roll /random value 0..max and run func as the winner
function macroengine:core/internal/world/entity/random_dispatch with storage macroengine:engine _rnd

# Cleanup
data remove storage macroengine:engine _rnd

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"entity/random ","color":"aqua"},{"text":"$(type)","color":"aqua"},{"text":" [$(tag)]","color":"gray"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
