data modify storage macroengine:output result set value 1b

$execute unless data storage macroengine:engine cooldowns.$(player).$(key) run return 0

$execute store result score $cd_exp macroengine.tmp run data get storage macroengine:engine cooldowns.$(player).$(key)
execute store result score $cd_now macroengine.tmp run scoreboard players get $epoch macroengine.time

execute if score $cd_now macroengine.tmp < $cd_exp macroengine.tmp run data modify storage macroengine:output result set value 0b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/check ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
