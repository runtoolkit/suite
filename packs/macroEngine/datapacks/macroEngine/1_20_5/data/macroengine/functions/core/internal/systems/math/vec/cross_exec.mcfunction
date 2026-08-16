# macroengine:systems/math/vec/internal/cross_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)

# cx = ay*bz - az*by
$scoreboard players set $vcay macroengine.tmp $(ay)
$scoreboard players set $vcbz macroengine.tmp $(bz)
scoreboard players operation $vcay macroengine.tmp *= $vcbz macroengine.tmp

$scoreboard players set $vcaz macroengine.tmp $(az)
$scoreboard players set $vcby macroengine.tmp $(by)
scoreboard players operation $vcaz macroengine.tmp *= $vcby macroengine.tmp

scoreboard players operation $vcay macroengine.tmp -= $vcaz macroengine.tmp
execute store result storage macroengine:output x int 1 run scoreboard players get $vcay macroengine.tmp

# cy = az*bx - ax*bz
$scoreboard players set $vcaz2 macroengine.tmp $(az)
$scoreboard players set $vcbx macroengine.tmp $(bx)
scoreboard players operation $vcaz2 macroengine.tmp *= $vcbx macroengine.tmp

$scoreboard players set $vcax macroengine.tmp $(ax)
$scoreboard players set $vcbz2 macroengine.tmp $(bz)
scoreboard players operation $vcax macroengine.tmp *= $vcbz2 macroengine.tmp

scoreboard players operation $vcaz2 macroengine.tmp -= $vcax macroengine.tmp
execute store result storage macroengine:output y int 1 run scoreboard players get $vcaz2 macroengine.tmp

# cz = ax*by - ay*bx
$scoreboard players set $vcax2 macroengine.tmp $(ax)
$scoreboard players set $vcby2 macroengine.tmp $(by)
scoreboard players operation $vcax2 macroengine.tmp *= $vcby2 macroengine.tmp

$scoreboard players set $vcay2 macroengine.tmp $(ay)
$scoreboard players set $vcbx2 macroengine.tmp $(bx)
scoreboard players operation $vcay2 macroengine.tmp *= $vcbx2 macroengine.tmp

scoreboard players operation $vcax2 macroengine.tmp -= $vcay2 macroengine.tmp
execute store result storage macroengine:output z int 1 run scoreboard players get $vcax2 macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/vec/cross ","color":"aqua"},{"text":"($(ax),$(ay),$(az))×($(bx),$(by),$(bz)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"x","color":"yellow"},{"text":",","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"y","color":"yellow"},{"text":",","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"z","color":"yellow"}]
