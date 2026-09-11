# ======================================================================================
# macroengine:input/private/cbm_process  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a single tagged command_block_minecart.
# Robust non-empty Command check + pending debounce.
# Debounce is now purely per-entity (macroengine.cbm_pending tag on @s),
# cleared by cbm_capture itself once handling is attempted — no shared
# executed:0b/1b flag, so no cross-talk between concurrent minecarts.
# ======================================================================================

# Pending capture: if this entity is still pending, cbm_capture hasn't
# released it yet (handler still running or never ran) — skip this tick.
execute if entity @s[tag=macroengine.cbm_pending] run return 0

# Snapshot Command into temporary storage
data remove storage macroengine:input _cbm
data modify storage macroengine:input _cbm.current set from entity @s Command

# Robust empty check via real NBT match (not "store success ... set from",
# which only tests source existence, not the value).
execute unless data storage macroengine:input _cbm.current run return 0
execute if data storage macroengine:input _cbm{current:""} run data remove storage macroengine:input _cbm
execute unless data storage macroengine:input _cbm.current run return 0

function macroengine:input/private/cbm_capture