# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/is_between
# Checks if value is in the inclusive range [min, max].
#  Input : $(value), $(min), $(max)
# Output: macroengine:output result → 1b (true) or 0b (false)
#
# Example:
# data modify storage macroengine:input value set value 15
# data modify storage macroengine:input min set value 10
# data modify storage macroengine:input max set value 20
# function macroengine:systems/math/is_between with storage macroengine:input {}
# # macroengine:output result = 1b
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $ib_v macroengine.tmp $(value)
$scoreboard players set $ib_lo macroengine.tmp $(min)
$scoreboard players set $ib_hi macroengine.tmp $(max)

data modify storage macroengine:output result set value 0b

execute if score $ib_v macroengine.tmp >= $ib_lo macroengine.tmp run execute if score $ib_v macroengine.tmp <= $ib_hi macroengine.tmp run data modify storage macroengine:output result set value 1b

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/is_between ","color":"aqua"},{"text":"$(value) in [$(min),$(max)] → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
