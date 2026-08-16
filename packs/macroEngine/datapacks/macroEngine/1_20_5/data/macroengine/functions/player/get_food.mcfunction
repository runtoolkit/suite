data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0

data modify storage macroengine:output found set value 1b
$execute as @a[name=$(player),limit=1] store result storage macroengine:output food int 1 run data get entity @s FoodLevel
$execute as @a[name=$(player),limit=1] store result storage macroengine:output saturation int 1000 run data get entity @s FoodSaturationLevel
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/get_food ","color":"aqua"},{"text":"$(player) → food=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"food","color":"green"},{"text":" sat=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"saturation","color":"green"}]