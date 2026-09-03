data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] store result storage macroengine:output level int 1 run data get entity @s XpLevel
$execute as @a[name=$(player),limit=1] store result storage macroengine:output points int 1 run xp query @s points
$execute as @a[name=$(player),limit=1] store result storage macroengine:output progress int 1000 run data get entity @s XpP
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/get_xp ","color":"aqua"},{"text":"$(player) → level=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"level","color":"green"},{"text":" pts=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"points","color":"green"}]