# ─────────────────────────────────────────────────────────────────
# macroengine:player/get_air
# Returns the current air supply of the named player.
# Air ranges from 0 (drowning) to 300 (full) in ticks.
#
# INPUT : $(player) → player name
# OUTPUT: macroengine:output result → air ticks (int, 0–300)
# macroengine:output found → 1b if player online, 0b otherwise
#
# EXAMPLE:
# function macroengine:player/get_air {player:"Steve"}
# → macroengine:output result = 300
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] store result storage macroengine:output result int 1 run data get entity @s Air
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/get_air ","color":"aqua"},{"text":"$(player) → air=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
