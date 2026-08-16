# ─────────────────────────────────────────────────────────────────
# macroengine:player/is_on_ground
# Checks whether a named player is currently on the ground.
# Uses the macroengine:is_on_ground predicate (entity_flags).
#
# INPUT : $(player) → player name
# OUTPUT: macroengine:output result → 1b if on ground, 0b otherwise
# macroengine:output found → 1b if player online, 0b otherwise
#
# EXAMPLE:
# function macroengine:player/is_on_ground {player:"Steve"}
# → macroengine:output result = 1b
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output found set value 0b
data modify storage macroengine:output result set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] if predicate macroengine:is_on_ground run data modify storage macroengine:output result set value 1b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/is_on_ground ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]