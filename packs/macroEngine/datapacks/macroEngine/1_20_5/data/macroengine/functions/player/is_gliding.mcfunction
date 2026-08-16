# ─────────────────────────────────────────────────────────────────
# macroengine:player/is_gliding
# Checks whether the named player is currently gliding with an elytra.
# Uses the macroengine:is_gliding predicate (entity_flags).
#
# INPUT : $(player) → player name
# OUTPUT: macroengine:output result → 1b if gliding, 0b otherwise
# macroengine:output found → 1b if player online, 0b otherwise
#
# EXAMPLE:
# function macroengine:player/is_gliding {player:"Steve"}
# → macroengine:output result = 1b
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output result set value 0b
data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] if predicate macroengine:is_gliding run data modify storage macroengine:output result set value 1b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/is_gliding ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
