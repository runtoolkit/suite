# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/sign_nonzero
# Returns -1 for negative, +1 for zero-or-positive.
# Useful when you need a non-zero multiplier (e.g. direction vectors).
#
# INPUT : $(value) → integer
# OUTPUT: macroengine:output result → 1 or -1
#
# EXAMPLE:
# function macroengine:systems/math/sign_nonzero {value:-5}
# → macroengine:output result = -1
# function macroengine:systems/math/sign_nonzero {value:0}
# → macroengine:output result = 1
# ─────────────────────────────────────────────────────────────────

$scoreboard players set #snz_v macroengine.tmp $(value)
data modify storage macroengine:output result set value 1
execute if score #snz_v macroengine.tmp matches ..-1 run data modify storage macroengine:output result set value -1
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/sign_nonzero ","color":"aqua"},{"text":"$(value) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
