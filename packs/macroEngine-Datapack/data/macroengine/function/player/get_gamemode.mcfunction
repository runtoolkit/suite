# macroengine:player/get_gamemode [MACRO]
# Returns the gamemode of a named player as an integer.
#
# INPUT:  $(player) — player name
# OUTPUT: macroengine:output result — 0=survival, 1=creative, 2=adventure, 3=spectator
# macroengine:output name — "survival" | "creative" | "adventure" | "spectator"
# macroengine:output found — 1b if player exists, 0b otherwise
#
# EXAMPLE:
# function macroengine:player/get_gamemode {player:"Steve"}
# data get storage macroengine:output name

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b

$execute if entity @a[name=$(player),gamemode=survival,limit=1] run data modify storage macroengine:output result set value 0
$execute if entity @a[name=$(player),gamemode=creative,limit=1] run data modify storage macroengine:output result set value 1
$execute if entity @a[name=$(player),gamemode=adventure,limit=1] run data modify storage macroengine:output result set value 2
$execute if entity @a[name=$(player),gamemode=spectator,limit=1] run data modify storage macroengine:output result set value 3

$execute if entity @a[name=$(player),gamemode=survival,limit=1] run data modify storage macroengine:output name set value "survival"
$execute if entity @a[name=$(player),gamemode=creative,limit=1] run data modify storage macroengine:output name set value "creative"
$execute if entity @a[name=$(player),gamemode=adventure,limit=1] run data modify storage macroengine:output name set value "adventure"
$execute if entity @a[name=$(player),gamemode=spectator,limit=1] run data modify storage macroengine:output name set value "spectator"

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/get_gamemode ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"name","color":"green"}]