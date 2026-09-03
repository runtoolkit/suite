$scoreboard players set $pl_v macroengine.tmp $(value)
$scoreboard players set $pl_w macroengine.tmp $(width)

scoreboard players set $pl_neg macroengine.tmp -1
execute if score $pl_v macroengine.tmp matches ..-1 run scoreboard players operation $pl_v macroengine.tmp *= $pl_neg macroengine.tmp

scoreboard players set $pl_digits macroengine.tmp 1
execute if score $pl_v macroengine.tmp matches 10.. run scoreboard players set $pl_digits macroengine.tmp 2
execute if score $pl_v macroengine.tmp matches 100.. run scoreboard players set $pl_digits macroengine.tmp 3
execute if score $pl_v macroengine.tmp matches 1000.. run scoreboard players set $pl_digits macroengine.tmp 4
execute if score $pl_v macroengine.tmp matches 10000.. run scoreboard players set $pl_digits macroengine.tmp 5
execute if score $pl_v macroengine.tmp matches 100000.. run scoreboard players set $pl_digits macroengine.tmp 6
execute if score $pl_v macroengine.tmp matches 1000000.. run scoreboard players set $pl_digits macroengine.tmp 7
execute if score $pl_v macroengine.tmp matches 10000000.. run scoreboard players set $pl_digits macroengine.tmp 8

scoreboard players operation $pl_pad macroengine.tmp = $pl_w macroengine.tmp
scoreboard players operation $pl_pad macroengine.tmp -= $pl_digits macroengine.tmp

data modify storage macroengine:output result set value ""

execute if score $pl_pad macroengine.tmp matches 1.. run data modify storage macroengine:output result set value "0"
execute if score $pl_pad macroengine.tmp matches 2.. run data modify storage macroengine:output result set value "00"
execute if score $pl_pad macroengine.tmp matches 3.. run data modify storage macroengine:output result set value "000"
execute if score $pl_pad macroengine.tmp matches 4.. run data modify storage macroengine:output result set value "0000"
execute if score $pl_pad macroengine.tmp matches 5.. run data modify storage macroengine:output result set value "00000"
execute if score $pl_pad macroengine.tmp matches 6.. run data modify storage macroengine:output result set value "000000"
execute if score $pl_pad macroengine.tmp matches 7.. run data modify storage macroengine:output result set value "0000000"

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/pad_left ","color":"aqua"},{"text":"$(value) w=$(width) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"},{"text":"[NUM]","color":"#555555"}]
