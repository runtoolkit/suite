# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/factorial
# Computes n! for integer n in range 0–12.
# Values outside this range are clamped:
# n < 0 → result = 0 (undefined)
# n > 12 → result = 0 (would overflow INT32)
#
# Input : $(n) → non-negative integer
# Output: macroengine:output result → n!
#
# Lookup table approach — avoids recursion overhead and is safe
# against scoreboard overflow (12! = 479001600 < 2147483647).
#
# Example:
# function macroengine:systems/math/factorial {n:5}
# # macroengine:output result = 120
# function macroengine:systems/math/factorial {n:0}
# # macroengine:output result = 1
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $fact_n macroengine.tmp $(n)

# Out-of-range guard
execute if score $fact_n macroengine.tmp matches ..-1 run data modify storage macroengine:output result set value 0
execute if score $fact_n macroengine.tmp matches ..-1 run return 0
execute if score $fact_n macroengine.tmp matches 13.. run data modify storage macroengine:output result set value 0
execute if score $fact_n macroengine.tmp matches 13.. run return 0

# Lookup table 0! – 12!
execute if score $fact_n macroengine.tmp matches 0 run data modify storage macroengine:output result set value 1
execute if score $fact_n macroengine.tmp matches 1 run data modify storage macroengine:output result set value 1
execute if score $fact_n macroengine.tmp matches 2 run data modify storage macroengine:output result set value 2
execute if score $fact_n macroengine.tmp matches 3 run data modify storage macroengine:output result set value 6
execute if score $fact_n macroengine.tmp matches 4 run data modify storage macroengine:output result set value 24
execute if score $fact_n macroengine.tmp matches 5 run data modify storage macroengine:output result set value 120
execute if score $fact_n macroengine.tmp matches 6 run data modify storage macroengine:output result set value 720
execute if score $fact_n macroengine.tmp matches 7 run data modify storage macroengine:output result set value 5040
execute if score $fact_n macroengine.tmp matches 8 run data modify storage macroengine:output result set value 40320
execute if score $fact_n macroengine.tmp matches 9 run data modify storage macroengine:output result set value 362880
execute if score $fact_n macroengine.tmp matches 10 run data modify storage macroengine:output result set value 3628800
execute if score $fact_n macroengine.tmp matches 11 run data modify storage macroengine:output result set value 39916800
execute if score $fact_n macroengine.tmp matches 12 run data modify storage macroengine:output result set value 479001600

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/factorial ","color":"aqua"},{"text":"$(n)! = ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
