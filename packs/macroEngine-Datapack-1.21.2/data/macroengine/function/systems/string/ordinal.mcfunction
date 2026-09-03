# ─────────────────────────────────────────────────────────────────
# macroengine:systems/string/ordinal
# Determines the English ordinal suffix for a positive integer.
# Handles the 11th/12th/13th exception correctly.
#
#  Input : $(n) → positive integer (1-based)
# Output: macroengine:output n → original value (int)
# macroengine:output suffix → "st" / "nd" / "rd" / "th"
#
# To display "3rd place" in chat:
# function macroengine:systems/string/ordinal {n:3}
# tellraw @a ["",
# {"plain":true ,"storage":"macroengine:output","nbt":"n"},
# {"plain":true ,"storage":"macroengine:output","nbt":"suffix","color":"gold"},
# {"text":" place"}]
#
# Examples:
# {n:1} → suffix="st" {n:11} → suffix="th"
# {n:2} → suffix="nd" {n:12} → suffix="th"
# {n:3} → suffix="rd" {n:13} → suffix="th"
# {n:4} → suffix="th" {n:21} → suffix="st"
# {n:22} → suffix="nd" {n:103}→ suffix="rd"
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $ord_n macroengine.tmp $(n)
execute store result storage macroengine:output n int 1 run scoreboard players get $ord_n macroengine.tmp

# last-two-digits mod 100 (teen detection)
scoreboard players operation $ord_h macroengine.tmp = $ord_n macroengine.tmp
scoreboard players set $ord_100 macroengine.tmp 100
scoreboard players operation $ord_h macroengine.tmp %= $ord_100 macroengine.tmp

# last digit mod 10 (suffix selection)
scoreboard players operation $ord_d macroengine.tmp = $ord_n macroengine.tmp
scoreboard players set $ord_10 macroengine.tmp 10
scoreboard players operation $ord_d macroengine.tmp %= $ord_10 macroengine.tmp

# Default: th
data modify storage macroengine:output suffix set value "th"

# Apply last-digit rules
execute if score $ord_d macroengine.tmp matches 1 run data modify storage macroengine:output suffix set value "st"
execute if score $ord_d macroengine.tmp matches 2 run data modify storage macroengine:output suffix set value "nd"
execute if score $ord_d macroengine.tmp matches 3 run data modify storage macroengine:output suffix set value "rd"

# Teen override — 11, 12, 13 must always be "th"
execute if score $ord_h macroengine.tmp matches 11..13 run data modify storage macroengine:output suffix set value "th"

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/ordinal ","color":"aqua"},{"text":"$(n)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"suffix","color":"green"}]
