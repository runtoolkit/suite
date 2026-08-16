$execute store result score $tr_f macroengine.tmp run data get storage macroengine:engine players.$(from).$(key)
$scoreboard players set $tr_a macroengine.tmp $(amount)
scoreboard players operation $tr_f macroengine.tmp -= $tr_a macroengine.tmp
$execute store result storage macroengine:engine players.$(from).$(key) int 1 run scoreboard players get $tr_f macroengine.tmp

$execute store result score $tr_t macroengine.tmp run data get storage macroengine:engine players.$(to).$(key)
scoreboard players operation $tr_t macroengine.tmp += $tr_a macroengine.tmp
$execute store result storage macroengine:engine players.$(to).$(key) int 1 run scoreboard players get $tr_t macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $tr_t macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/transfer_var ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]