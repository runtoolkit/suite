data modify storage macroengine:output result set value 0b

$scoreboard players set $rgn_x macroengine.tmp $(x)
$scoreboard players set $rgn_y macroengine.tmp $(y)
$scoreboard players set $rgn_z macroengine.tmp $(z)
$scoreboard players set $rgn_x1 macroengine.tmp $(x1)
$scoreboard players set $rgn_y1 macroengine.tmp $(y1)
$scoreboard players set $rgn_z1 macroengine.tmp $(z1)
$scoreboard players set $rgn_x2 macroengine.tmp $(x2)
$scoreboard players set $rgn_y2 macroengine.tmp $(y2)
$scoreboard players set $rgn_z2 macroengine.tmp $(z2)

# min/max normalization
execute if score $rgn_x1 macroengine.tmp > $rgn_x2 macroengine.tmp run scoreboard players operation $rgn_t macroengine.tmp = $rgn_x1 macroengine.tmp
execute if score $rgn_x1 macroengine.tmp > $rgn_x2 macroengine.tmp run scoreboard players operation $rgn_x1 macroengine.tmp = $rgn_x2 macroengine.tmp
execute if score $rgn_t macroengine.tmp > $rgn_x2 macroengine.tmp run scoreboard players operation $rgn_x2 macroengine.tmp = $rgn_t macroengine.tmp

execute if score $rgn_y1 macroengine.tmp > $rgn_y2 macroengine.tmp run scoreboard players operation $rgn_t macroengine.tmp = $rgn_y1 macroengine.tmp
execute if score $rgn_y1 macroengine.tmp > $rgn_y2 macroengine.tmp run scoreboard players operation $rgn_y1 macroengine.tmp = $rgn_y2 macroengine.tmp
execute if score $rgn_t macroengine.tmp > $rgn_y2 macroengine.tmp run scoreboard players operation $rgn_y2 macroengine.tmp = $rgn_t macroengine.tmp

execute if score $rgn_z1 macroengine.tmp > $rgn_z2 macroengine.tmp run scoreboard players operation $rgn_t macroengine.tmp = $rgn_z1 macroengine.tmp
execute if score $rgn_z1 macroengine.tmp > $rgn_z2 macroengine.tmp run scoreboard players operation $rgn_z1 macroengine.tmp = $rgn_z2 macroengine.tmp
execute if score $rgn_t macroengine.tmp > $rgn_z2 macroengine.tmp run scoreboard players operation $rgn_z2 macroengine.tmp = $rgn_t macroengine.tmp

execute if score $rgn_x macroengine.tmp < $rgn_x1 macroengine.tmp run return 0
execute if score $rgn_x macroengine.tmp > $rgn_x2 macroengine.tmp run return 0
execute if score $rgn_y macroengine.tmp < $rgn_y1 macroengine.tmp run return 0
execute if score $rgn_y macroengine.tmp > $rgn_y2 macroengine.tmp run return 0
execute if score $rgn_z macroengine.tmp < $rgn_z1 macroengine.tmp run return 0
execute if score $rgn_z macroengine.tmp > $rgn_z2 macroengine.tmp run return 0

data modify storage macroengine:output result set value 1b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"geo/in_region ","color":"aqua"},{"text":"($(x),$(y),$(z)) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
