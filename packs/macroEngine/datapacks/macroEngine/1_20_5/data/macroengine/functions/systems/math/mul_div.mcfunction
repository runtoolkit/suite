# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/mul_div
# Computes floor(a * b / c) without 32-bit integer overflow.
# Uses the identity: floor(a*b/c) = (a/c)*b + (a%c)*b/c
# This avoids overflow when a*b would exceed ±2147483647.
# Input : $(a), $(b), $(c) → integers; c must not be 0
# Output: macroengine:output result → floor(a * b / c)
#
# Note: if (a % c) * b still overflows (e.g. huge b with c=1),
# the result is clamped by Java's 32-bit signed wrapping.
# For those cases, reduce inputs before calling.
#
# Example:
# data modify storage macroengine:input a set value 1000000
# data modify storage macroengine:input b set value 1000000
# data modify storage macroengine:input c set value 500000
# function macroengine:systems/math/mul_div with storage macroengine:input {}
# # macroengine:output result = 2000000
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $md_a macroengine.tmp $(a)
$scoreboard players set $md_b macroengine.tmp $(b)
$scoreboard players set $md_c macroengine.tmp $(c)

# Guard: c = 0 → undefined, return 0
execute if score $md_c macroengine.tmp matches 0 run data modify storage macroengine:output result set value 0
execute if score $md_c macroengine.tmp matches 0 run return 0

# q = a / c (integer quotient)
scoreboard players operation $md_q macroengine.tmp = $md_a macroengine.tmp
scoreboard players operation $md_q macroengine.tmp /= $md_c macroengine.tmp

# r = a % c (remainder, Java truncated — may be negative)
scoreboard players operation $md_r macroengine.tmp = $md_a macroengine.tmp
scoreboard players operation $md_r macroengine.tmp %= $md_c macroengine.tmp

# result = q * b + r * b / c
scoreboard players operation $md_q macroengine.tmp *= $md_b macroengine.tmp
scoreboard players operation $md_r macroengine.tmp *= $md_b macroengine.tmp
scoreboard players operation $md_r macroengine.tmp /= $md_c macroengine.tmp
scoreboard players operation $md_q macroengine.tmp += $md_r macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $md_q macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/mul_div ","color":"aqua"},{"text":"($(a)*$(b)/$(c)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
