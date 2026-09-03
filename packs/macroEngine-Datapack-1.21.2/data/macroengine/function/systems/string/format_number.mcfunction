# ─────────────────────────────────────────────────────────────────
# macroengine:systems/string/format_number
# Converts large numbers to readable abbreviations.
#  Input : $(value) → integer
# Output: macroengine:output text → abbreviated text (storage string)
# macroengine:output value → original value
# macroengine:output suffix → k / M / B / "" suffix
# macroengine:output short → abbreviated integer part
#
# Examples:
# 500 → "500"
# 1500 → "1.5k"
# 1000000 → "1M"
# 2500000 → "2.5M"
# 1000000000 → "1B"
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $fn_v macroengine.tmp $(value)
execute store result storage macroengine:output value int 1 run scoreboard players get $fn_v macroengine.tmp

# < 1000 → plain number
execute if score $fn_v macroengine.tmp matches ..999 run data modify storage macroengine:output suffix set value ""
execute if score $fn_v macroengine.tmp matches ..999 run execute store result storage macroengine:output short int 1 run scoreboard players get $fn_v macroengine.tmp
execute if score $fn_v macroengine.tmp matches ..999 run return 0

# 1000 – 999999 → k
execute if score $fn_v macroengine.tmp matches 1000..999999 run data modify storage macroengine:output suffix set value "k"
execute if score $fn_v macroengine.tmp matches 1000..999999 run scoreboard players set $fn_div macroengine.tmp 100
execute if score $fn_v macroengine.tmp matches 1000..999999 run scoreboard players operation $fn_v macroengine.tmp /= $fn_div macroengine.tmp
execute if score $fn_v macroengine.tmp matches 1000..999999 run execute store result storage macroengine:output short int 1 run scoreboard players get $fn_v macroengine.tmp
execute if score $fn_v macroengine.tmp matches 1000..999999 run return 0

# 1_000_000 – 999_999_999 → M
execute if score $fn_v macroengine.tmp matches 1000000..999999999 run data modify storage macroengine:output suffix set value "M"
execute if score $fn_v macroengine.tmp matches 1000000..999999999 run scoreboard players set $fn_div macroengine.tmp 100000
execute if score $fn_v macroengine.tmp matches 1000000..999999999 run scoreboard players operation $fn_v macroengine.tmp /= $fn_div macroengine.tmp
execute if score $fn_v macroengine.tmp matches 1000000..999999999 run execute store result storage macroengine:output short int 1 run scoreboard players get $fn_v macroengine.tmp
execute if score $fn_v macroengine.tmp matches 1000000..999999999 run return 0

# >= 1_000_000_000 → B
execute if score $fn_v macroengine.tmp matches 1000000000.. run data modify storage macroengine:output suffix set value "B"
execute if score $fn_v macroengine.tmp matches 1000000000.. run scoreboard players set $fn_div macroengine.tmp 100000000
execute if score $fn_v macroengine.tmp matches 1000000000.. run scoreboard players operation $fn_v macroengine.tmp /= $fn_div macroengine.tmp
execute if score $fn_v macroengine.tmp matches 1000000000.. run execute store result storage macroengine:output short int 1 run scoreboard players get $fn_v macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/format_number ","color":"aqua"},{"text":"$(value) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"short","color":"green"},{"plain":true ,"storage":"macroengine:output","nbt":"suffix","color":"green"}]
