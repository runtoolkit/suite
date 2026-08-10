# ─────────────────────────────────────────────────────────────────
# macro:world/time_phase
# Time phase detection compatible with 26.1+ World Clocks
#
# OUTPUT:
# macro:output.phase → "dawn" / "day" / "dusk" / "night"
# macro:output.daytime → raw daytime tick (0–23999)
# macro:output.is_day → 1b (daytime)
# macro:output.is_night → 1b (nighttime)
# macro:output.is_dawn → 1b (dawn)
# macro:output.is_dusk → 1b (dusk)
# ─────────────────────────────────────────────────────────────────

# Get in-day time (26.1+ correct syntax)
execute store result score $tp_t macro.tmp run time of minecraft:overworld query day

# Write raw daytime to storage
execute store result storage macro:output daytime int 1 run scoreboard players get $tp_t macro.tmp

# Reset boolean flags
data modify storage macro:output is_day set value 0b
data modify storage macro:output is_night set value 0b
data modify storage macro:output is_dawn set value 0b
data modify storage macro:output is_dusk set value 0b

# Set boolean values
execute if score $tp_t macro.tmp matches 0..12999 run data modify storage macro:output is_day set value 1b
execute if score $tp_t macro.tmp matches 13000..23999 run data modify storage macro:output is_night set value 1b
execute if score $tp_t macro.tmp matches 0..999 run data modify storage macro:output is_dawn set value 1b
execute if score $tp_t macro.tmp matches 12000..13799 run data modify storage macro:output is_dusk set value 1b

# Determine phase name
execute if score $tp_t macro.tmp matches 0..999 run data modify storage macro:output phase set value "dawn"
execute if score $tp_t macro.tmp matches 1000..11999 run data modify storage macro:output phase set value "day"
execute if score $tp_t macro.tmp matches 12000..13799 run data modify storage macro:output phase set value "dusk"
execute if score $tp_t macro.tmp matches 13800..23999 run data modify storage macro:output phase set value "night"

# Debug message (optional)
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"world/time_phase ","color":"aqua"},{"storage":"macro:output","nbt":"phase","color":"green"},{"text":" t=","color":"gray"},{"storage":"macro:output","nbt":"daytime","color":"white"}]
