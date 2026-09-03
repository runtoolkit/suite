# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/lcm
# EKOK (LCM) hesaplar: lcm(a,b) = |a*b| / gcd(a,b)
#  Input : $(a), $(b)          → integers
# Output: macroengine:output result → LCM(a, b)
# NOTE : Overflow risk — result may exceed INT_MAX for large inputs.
#
# Example:
# data modify storage macroengine:input a set value 12
# data modify storage macroengine:input b set value 8
# function macroengine:systems/math/lcm with storage macroengine:input {}
# # macroengine:output result = 24
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $lcm_a macroengine.tmp $(a)
$scoreboard players set $lcm_b macroengine.tmp $(b)

# Zero check
execute if score $lcm_a macroengine.tmp matches 0 run data modify storage macroengine:output result set value 0
execute if score $lcm_a macroengine.tmp matches 0 run return 0
execute if score $lcm_b macroengine.tmp matches 0 run data modify storage macroengine:output result set value 0
execute if score $lcm_b macroengine.tmp matches 0 run return 0

# Absolute value
scoreboard players set $lcm_neg macroengine.tmp -1
execute if score $lcm_a macroengine.tmp matches ..-1 run scoreboard players operation $lcm_a macroengine.tmp *= $lcm_neg macroengine.tmp
execute if score $lcm_b macroengine.tmp matches ..-1 run scoreboard players operation $lcm_b macroengine.tmp *= $lcm_neg macroengine.tmp

# Compute GCD (lcm_a, lcm_b share gcd_a, gcd_b variables)
scoreboard players operation $gcd_a macroengine.tmp = $lcm_a macroengine.tmp
scoreboard players operation $gcd_b macroengine.tmp = $lcm_b macroengine.tmp
function macroengine:core/internal/systems/math/gcd_loop

# lcm = (a / gcd) * b (divide first to prevent overflow)
scoreboard players operation $lcm_a macroengine.tmp /= $gcd_a macroengine.tmp
scoreboard players operation $lcm_a macroengine.tmp *= $lcm_b macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $lcm_a macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/lcm ","color":"aqua"},{"text":"($(a),$(b)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
