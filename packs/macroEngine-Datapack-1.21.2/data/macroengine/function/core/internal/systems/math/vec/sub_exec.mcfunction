# macroengine:systems/math/vec/internal/sub_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)

$scoreboard players set $vx macroengine.tmp $(ax)
$scoreboard players set $vy macroengine.tmp $(ay)
$scoreboard players set $vz macroengine.tmp $(az)
$scoreboard players remove $vx macroengine.tmp $(bx)
$scoreboard players remove $vy macroengine.tmp $(by)
$scoreboard players remove $vz macroengine.tmp $(bz)

execute store result storage macroengine:output x int 1 run scoreboard players get $vx macroengine.tmp
execute store result storage macroengine:output y int 1 run scoreboard players get $vy macroengine.tmp
execute store result storage macroengine:output z int 1 run scoreboard players get $vz macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/vec/sub ","color":"aqua"},{"text":"($(ax),$(ay),$(az))-($(bx),$(by),$(bz)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"x","color":"yellow"},{"text":",","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"y","color":"yellow"},{"text":",","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"z","color":"yellow"}]
