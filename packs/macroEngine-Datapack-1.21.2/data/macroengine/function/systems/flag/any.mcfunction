# ─────────────────────────────────────────────────────────────────
# macroengine:systems/flag/any
# Checks whether ANY of two flags is set.
# Returns 1b if at least one of key_a or key_b is set, 0b otherwise.
# For three or more flags, chain calls or use flag/get on each.
#
# INPUT : $(key_a) → first flag key
#         $(key_b) → second flag key
# OUTPUT: macroengine:output result → 1b if either flag set, 0b if neither
# macroengine:output result_a → 1b if key_a set, 0b otherwise
# macroengine:output result_b → 1b if key_b set, 0b otherwise
#
# EXAMPLE:
# function macroengine:systems/flag/any {key_a:"pvp_enabled",key_b:"war_active"}
# → macroengine:output result = 1b (if either is set)
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output result_a set value 0b
data modify storage macroengine:output result_b set value 0b
data modify storage macroengine:output result set value 0b

scoreboard players set #fany_a macroengine.tmp 0
scoreboard players set #fany_b macroengine.tmp 0

$execute if data storage macroengine:engine flags.$(key_a) run scoreboard players set #fany_a macroengine.tmp 1
$execute if data storage macroengine:engine flags.$(key_b) run scoreboard players set #fany_b macroengine.tmp 1

execute if score #fany_a macroengine.tmp matches 1 run data modify storage macroengine:output result_a set value 1b
execute if score #fany_b macroengine.tmp matches 1 run data modify storage macroengine:output result_b set value 1b

scoreboard players operation #fany_a macroengine.tmp += #fany_b macroengine.tmp
execute if score #fany_a macroengine.tmp matches 1.. run data modify storage macroengine:output result set value 1b

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"flag/any ","color":"aqua"},{"text":"$(key_a)|$(key_b) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
