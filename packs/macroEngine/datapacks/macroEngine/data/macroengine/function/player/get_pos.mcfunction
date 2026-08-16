data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] at @s store result storage macroengine:output x int 1 run data get entity @s Pos[0]
$execute as @a[name=$(player),limit=1] at @s store result storage macroengine:output y int 1 run data get entity @s Pos[1]
$execute as @a[name=$(player),limit=1] at @s store result storage macroengine:output z int 1 run data get entity @s Pos[2]
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/get_pos ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"x=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"x","color":"green"},{"text":" y=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"y","color":"green"},{"text":" z=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"z","color":"green"}]