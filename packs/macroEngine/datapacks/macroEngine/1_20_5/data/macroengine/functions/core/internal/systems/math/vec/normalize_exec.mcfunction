# macroengine:systems/math/vec/internal/normalize_exec [MACRO]
# INPUT: $(x), $(y), $(z)
# Compute length via math/distance3d, then ×1000 / length
# RULE: Lines without $(var) must NOT have a $ prefix.

function macroengine:core/lib/input_push

data modify storage macroengine:engine _math_d3d_tmp.x1 set value 0
data modify storage macroengine:engine _math_d3d_tmp.y1 set value 0
data modify storage macroengine:engine _math_d3d_tmp.z1 set value 0
$data modify storage macroengine:engine _math_d3d_tmp x2 set value $(x)
$data modify storage macroengine:engine _math_d3d_tmp y2 set value $(y)
$data modify storage macroengine:engine _math_d3d_tmp z2 set value $(z)
function macroengine:systems/math/distance3d with storage macroengine:engine _math_d3d_tmp

function macroengine:core/lib/input_pop

execute store result score $vnlen macroengine.tmp run data get storage macroengine:output result

execute if score $vnlen macroengine.tmp matches 0 run data modify storage macroengine:output x set value 0
execute if score $vnlen macroengine.tmp matches 0 run data modify storage macroengine:output y set value 0
execute if score $vnlen macroengine.tmp matches 0 run data modify storage macroengine:output z set value 0
execute if score $vnlen macroengine.tmp matches 0 run data modify storage macroengine:output length set value 0
execute if score $vnlen macroengine.tmp matches 0 run return 0

execute store result storage macroengine:output length int 1 run scoreboard players get $vnlen macroengine.tmp

$scoreboard players set $vnx macroengine.tmp $(x)
scoreboard players set $vn1000 macroengine.tmp 1000
scoreboard players operation $vnx macroengine.tmp *= $vn1000 macroengine.tmp
scoreboard players operation $vnx macroengine.tmp /= $vnlen macroengine.tmp
execute store result storage macroengine:output x int 1 run scoreboard players get $vnx macroengine.tmp

$scoreboard players set $vny macroengine.tmp $(y)
scoreboard players operation $vny macroengine.tmp *= $vn1000 macroengine.tmp
scoreboard players operation $vny macroengine.tmp /= $vnlen macroengine.tmp
execute store result storage macroengine:output y int 1 run scoreboard players get $vny macroengine.tmp

$scoreboard players set $vnz macroengine.tmp $(z)
scoreboard players operation $vnz macroengine.tmp *= $vn1000 macroengine.tmp
scoreboard players operation $vnz macroengine.tmp /= $vnlen macroengine.tmp
execute store result storage macroengine:output z int 1 run scoreboard players get $vnz macroengine.tmp

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/vec/normalize ","color":"aqua"},{"text":"len=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"length","color":"yellow"},{"text":" → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"x","color":"yellow"},{"text":",","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"y","color":"yellow"},{"text":",","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"z","color":"yellow"}]
