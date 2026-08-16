$execute store result score $pvar macroengine.tmp run data get storage macroengine:engine players.$(player).$(key)
$scoreboard players set $pamount macroengine.tmp $(amount)
scoreboard players operation $pvar macroengine.tmp += $pamount macroengine.tmp
$execute store result storage macroengine:engine players.$(player).$(key) int 1 run scoreboard players get $pvar macroengine.tmp
execute store result storage macroengine:output result int 1 run scoreboard players get $pvar macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/add_to_var ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]