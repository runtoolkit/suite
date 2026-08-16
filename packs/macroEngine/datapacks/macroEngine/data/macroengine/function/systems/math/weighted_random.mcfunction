$scoreboard players set $wr_total macroengine.tmp $(total)

execute if score $wr_total macroengine.tmp matches ..0 run data modify storage macroengine:output result set value -1
execute if score $wr_total macroengine.tmp matches ..0 run return 0

# Draw random in range 0..total-1
data modify storage macroengine:engine _math_rnd_tmp.min set value 0
scoreboard players remove $wr_total macroengine.tmp 1
execute store result storage macroengine:engine _math_rnd_tmp.max int 1 run scoreboard players get $wr_total macroengine.tmp
function macroengine:systems/math/random with storage macroengine:engine _math_rnd_tmp

execute store result score $wr_roll macroengine.tmp run data get storage macroengine:output result
execute store result storage macroengine:output roll int 1 run scoreboard players get $wr_roll macroengine.tmp

data modify storage macroengine:output result set value -1
scoreboard players set $wr_done macroengine.tmp 0

# Cumulative threshold check
$scoreboard players set $wr_acc macroengine.tmp $(w0)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 0
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w1)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 1
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w2)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 2
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w3)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 3
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w4)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 4
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w5)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 5
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w6)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 6
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w7)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 7
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w8)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 8
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$scoreboard players add $wr_acc macroengine.tmp $(w9)
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run data modify storage macroengine:output result set value 9
execute if score $wr_done macroengine.tmp matches 0 run execute if score $wr_roll macroengine.tmp < $wr_acc macroengine.tmp run scoreboard players set $wr_done macroengine.tmp 1

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/weighted_random ","color":"aqua"},{"text":"total=$(total) roll=","color":"gray"},{"score":{"name":"$wr_roll","objective":"macroengine.tmp"},"color":"yellow"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
