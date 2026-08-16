# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/round
# Rounds a value to the nearest multiple of a given step.
# Integer division truncates toward zero; adding half the step before
# dividing gives standard rounding (0.5 rounds away from zero).
#
# INPUT : $(value) → integer to round
# $(step) → rounding step (must be > 0)
# OUTPUT: macroengine:output result → rounded value
#
# EXAMPLE:
# function macroengine:systems/math/round {value:37, step:10}
# → macroengine:output result = 40
# function macroengine:systems/math/round {value:34, step:10}
# → macroengine:output result = 30
# ─────────────────────────────────────────────────────────────────

$scoreboard players set #rnd_v macroengine.tmp $(value)
$scoreboard players set #rnd_s macroengine.tmp $(step)

execute if score #rnd_s macroengine.tmp matches ..0 run return fail

# add half step for rounding (integer division: step=10 → half=5)
scoreboard players operation #rnd_half macroengine.tmp = #rnd_s macroengine.tmp
scoreboard players set #rnd_2 macroengine.tmp 2
scoreboard players operation #rnd_half macroengine.tmp /= #rnd_2 macroengine.tmp

execute if score #rnd_v macroengine.tmp matches 0.. run scoreboard players operation #rnd_v macroengine.tmp += #rnd_half macroengine.tmp
execute if score #rnd_v macroengine.tmp matches ..-1 run scoreboard players operation #rnd_v macroengine.tmp -= #rnd_half macroengine.tmp

scoreboard players operation #rnd_v macroengine.tmp /= #rnd_s macroengine.tmp
scoreboard players operation #rnd_v macroengine.tmp *= #rnd_s macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get #rnd_v macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/round ","color":"aqua"},{"text":"$(value) step=$(step) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
