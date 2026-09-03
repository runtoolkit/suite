# macroengine:systems/math/vec/internal/angle_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)
# RULE: Lines without $(var) must NOT have a $ prefix.

function macroengine:core/lib/input_push

$data modify storage macroengine:engine _vec_dot_tmp ax set value $(ax)
$data modify storage macroengine:engine _vec_dot_tmp ay set value $(ay)
$data modify storage macroengine:engine _vec_dot_tmp az set value $(az)
$data modify storage macroengine:engine _vec_dot_tmp bx set value $(bx)
$data modify storage macroengine:engine _vec_dot_tmp by set value $(by)
$data modify storage macroengine:engine _vec_dot_tmp bz set value $(bz)
function macroengine:systems/math/vec/dot with storage macroengine:engine _vec_dot_tmp
execute store result score $vang_dot macroengine.tmp run data get storage macroengine:output result

data modify storage macroengine:engine _math_d3d_tmp.x1 set value 0
data modify storage macroengine:engine _math_d3d_tmp.y1 set value 0
data modify storage macroengine:engine _math_d3d_tmp.z1 set value 0
$data modify storage macroengine:engine _math_d3d_tmp x2 set value $(ax)
$data modify storage macroengine:engine _math_d3d_tmp y2 set value $(ay)
$data modify storage macroengine:engine _math_d3d_tmp z2 set value $(az)
function macroengine:systems/math/distance3d with storage macroengine:engine _math_d3d_tmp
execute store result score $vang_la macroengine.tmp run data get storage macroengine:output result

$data modify storage macroengine:engine _math_d3d_tmp x2 set value $(bx)
$data modify storage macroengine:engine _math_d3d_tmp y2 set value $(by)
$data modify storage macroengine:engine _math_d3d_tmp z2 set value $(bz)
function macroengine:systems/math/distance3d with storage macroengine:engine _math_d3d_tmp
execute store result score $vang_lb macroengine.tmp run data get storage macroengine:output result

function macroengine:core/lib/input_pop

data modify storage macroengine:output result set value 0

execute if score $vang_la macroengine.tmp matches 0 run return 0
execute if score $vang_lb macroengine.tmp matches 0 run return 0

scoreboard players set $vang_1000 macroengine.tmp 1000
scoreboard players operation $vang_dot macroengine.tmp *= $vang_1000 macroengine.tmp
scoreboard players operation $vang_la macroengine.tmp *= $vang_lb macroengine.tmp
scoreboard players operation $vang_dot macroengine.tmp /= $vang_la macroengine.tmp

execute if score $vang_dot macroengine.tmp matches 1001.. run scoreboard players set $vang_dot macroengine.tmp 1000
execute if score $vang_dot macroengine.tmp matches ..-1001 run scoreboard players set $vang_dot macroengine.tmp -1000

execute store result storage macroengine:engine _vang_cos int 1 run scoreboard players get $vang_dot macroengine.tmp
function macroengine:core/internal/systems/math/vec/arccos_lookup
