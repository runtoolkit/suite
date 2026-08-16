data modify storage macroengine:output result set value 0b

$scoreboard players set $sph_dx macroengine.tmp $(x)
$scoreboard players set $sph_cx macroengine.tmp $(cx)
scoreboard players operation $sph_dx macroengine.tmp -= $sph_cx macroengine.tmp

$scoreboard players set $sph_dy macroengine.tmp $(y)
$scoreboard players set $sph_cy macroengine.tmp $(cy)
scoreboard players operation $sph_dy macroengine.tmp -= $sph_cy macroengine.tmp

$scoreboard players set $sph_dz macroengine.tmp $(z)
$scoreboard players set $sph_cz macroengine.tmp $(cz)
scoreboard players operation $sph_dz macroengine.tmp -= $sph_cz macroengine.tmp

# Overflow prevention (max 26754 per axis)
execute if score $sph_dx macroengine.tmp matches 26755.. run scoreboard players set $sph_dx macroengine.tmp 26754
execute if score $sph_dx macroengine.tmp matches ..-26755 run scoreboard players set $sph_dx macroengine.tmp -26754
execute if score $sph_dy macroengine.tmp matches 26755.. run scoreboard players set $sph_dy macroengine.tmp 26754
execute if score $sph_dy macroengine.tmp matches ..-26755 run scoreboard players set $sph_dy macroengine.tmp -26754
execute if score $sph_dz macroengine.tmp matches 26755.. run scoreboard players set $sph_dz macroengine.tmp 26754
execute if score $sph_dz macroengine.tmp matches ..-26755 run scoreboard players set $sph_dz macroengine.tmp -26754

scoreboard players operation $sph_dx macroengine.tmp *= $sph_dx macroengine.tmp
scoreboard players operation $sph_dy macroengine.tmp *= $sph_dy macroengine.tmp
scoreboard players operation $sph_dz macroengine.tmp *= $sph_dz macroengine.tmp

scoreboard players operation $sph_dsq macroengine.tmp = $sph_dx macroengine.tmp
scoreboard players operation $sph_dsq macroengine.tmp += $sph_dy macroengine.tmp
scoreboard players operation $sph_dsq macroengine.tmp += $sph_dz macroengine.tmp
execute store result storage macroengine:output dist_sq int 1 run scoreboard players get $sph_dsq macroengine.tmp

$scoreboard players set $sph_r macroengine.tmp $(r)
scoreboard players operation $sph_r macroengine.tmp *= $sph_r macroengine.tmp

execute if score $sph_dsq macroengine.tmp <= $sph_r macroengine.tmp run data modify storage macroengine:output result set value 1b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"geo/in_sphere ","color":"aqua"},{"text":"r=$(r) dsq=","color":"gray"},{"score":{"name":"$sph_dsq","objective":"macroengine.tmp"},"color":"yellow"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
