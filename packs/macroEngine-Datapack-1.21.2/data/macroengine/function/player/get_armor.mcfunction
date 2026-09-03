# ─────────────────────────────────────────────────────────────────
# macroengine:player/get_armor
# Returns the armor point value of the named player.
# Armor is read from the generic.armor attribute base value.
# Also returns armor toughness.
#
# INPUT : $(player) → player name
# OUTPUT: macroengine:output result → armor points (int)
# macroengine:output toughness → armor toughness (int, scaled x1000)
# macroengine:output found → 1b if player exists, 0b otherwise
#
# EXAMPLE:
# function macroengine:player/get_armor {player:"Steve"}
# data get storage macroengine:output result
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] store result storage macroengine:output result int 1 run data get entity @s Attributes[{Name:"minecraft:armor"}].Base
$execute as @a[name=$(player),limit=1] store result storage macroengine:output toughness int 1000 run data get entity @s Attributes[{Name:"minecraft:armor_toughness"}].Base
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/get_armor ","color":"aqua"},{"text":"$(player) → armor=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"},{"text":" toughness=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"toughness","color":"green"}]