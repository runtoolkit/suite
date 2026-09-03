# macroengine:systems/math/vec/internal/dot_exec [MACRO]
# INPUT: $(ax), $(ay), $(az), $(bx), $(by), $(bz)

$scoreboard players set $vdax macroengine.tmp $(ax)
$scoreboard players set $vdbx macroengine.tmp $(bx)
scoreboard players operation $vdax macroengine.tmp *= $vdbx macroengine.tmp

$scoreboard players set $vday macroengine.tmp $(ay)
$scoreboard players set $vdby macroengine.tmp $(by)
scoreboard players operation $vday macroengine.tmp *= $vdby macroengine.tmp

$scoreboard players set $vdaz macroengine.tmp $(az)
$scoreboard players set $vdbz macroengine.tmp $(bz)
scoreboard players operation $vdaz macroengine.tmp *= $vdbz macroengine.tmp

scoreboard players operation $vdax macroengine.tmp += $vday macroengine.tmp
scoreboard players operation $vdax macroengine.tmp += $vdaz macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $vdax macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/vec/dot ","color":"aqua"},{"text":"($(ax),$(ay),$(az))·($(bx),$(by),$(bz)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"yellow"}]
