# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/gcd
# Computes GCD using the Euclidean algorithm.
#  Input : $(a), $(b)          → integers (may be negative)
# Output: macroengine:output result → GCD(|a|, |b|)
#
# Example:
# data modify storage macroengine:input a set value 48
# data modify storage macroengine:input b set value 18
# function macroengine:systems/math/gcd with storage macroengine:input {}
# # macroengine:output result = 6
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $gcd_a macroengine.tmp $(a)
$scoreboard players set $gcd_b macroengine.tmp $(b)

# Take absolute value
scoreboard players set $gcd_neg macroengine.tmp -1
execute if score $gcd_a macroengine.tmp matches ..-1 run scoreboard players operation $gcd_a macroengine.tmp *= $gcd_neg macroengine.tmp
execute if score $gcd_b macroengine.tmp matches ..-1 run scoreboard players operation $gcd_b macroengine.tmp *= $gcd_neg macroengine.tmp

# b=0 → result is a
execute if score $gcd_b macroengine.tmp matches 0 run execute store result storage macroengine:output result int 1 run scoreboard players get $gcd_a macroengine.tmp
execute if score $gcd_b macroengine.tmp matches 0 run return 0

# Euclidean loop (inner function)
function macroengine:core/internal/systems/math/gcd_loop

execute store result storage macroengine:output result int 1 run scoreboard players get $gcd_a macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/gcd ","color":"aqua"},{"text":"($(a),$(b)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
