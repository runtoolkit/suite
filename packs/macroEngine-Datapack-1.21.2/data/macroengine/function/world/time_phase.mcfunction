# ─────────────────────────────────────────────────────────────────
# macroengine:world/time_phase
# Time phase detection compatible with 26.1+ World Clocks
#
# OUTPUT:
# macroengine:output.phase → "dawn" / "day" / "dusk" / "night"
# macroengine:output.daytime → raw daytime tick (0–23999)
# macroengine:output.is_day → 1b (daytime)
# macroengine:output.is_night → 1b (nighttime)
# macroengine:output.is_dawn → 1b (dawn)
# macroengine:output.is_dusk → 1b (dusk)
# ─────────────────────────────────────────────────────────────────

# Get in-day time (26.1+ correct syntax)
execute store result score $tp_t macroengine.tmp run time query daytime

# Write raw daytime to storage
execute store result storage macroengine:output daytime int 1 run scoreboard players get $tp_t macroengine.tmp

# Reset boolean flags
data modify storage macroengine:output is_day set value 0b
data modify storage macroengine:output is_night set value 0b
data modify storage macroengine:output is_dawn set value 0b
data modify storage macroengine:output is_dusk set value 0b

# Set boolean values
execute if score $tp_t macroengine.tmp matches 0..12999 run data modify storage macroengine:output is_day set value 1b
execute if score $tp_t macroengine.tmp matches 13000..23999 run data modify storage macroengine:output is_night set value 1b
execute if score $tp_t macroengine.tmp matches 0..999 run data modify storage macroengine:output is_dawn set value 1b
execute if score $tp_t macroengine.tmp matches 12000..13799 run data modify storage macroengine:output is_dusk set value 1b

# Determine phase name
execute if score $tp_t macroengine.tmp matches 0..999 run data modify storage macroengine:output phase set value "dawn"
execute if score $tp_t macroengine.tmp matches 1000..11999 run data modify storage macroengine:output phase set value "day"
execute if score $tp_t macroengine.tmp matches 12000..13799 run data modify storage macroengine:output phase set value "dusk"
execute if score $tp_t macroengine.tmp matches 13800..23999 run data modify storage macroengine:output phase set value "night"

# Debug message (optional)
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"world/time_phase ","color":"aqua"},{"plain":true ,"storage":"macroengine:output","nbt":"phase","color":"green"},{"text":" t=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"daytime","color":"white"}]
