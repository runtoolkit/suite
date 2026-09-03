scoreboard players set $pc_pid macroengine.tmp 0
$execute store result score $pc_pid macroengine.tmp run data get storage macroengine:engine player_pids.$(player)
execute if score $pc_pid macroengine.tmp matches 0 run return 0

execute as @a if score @s macroengine.pid = $pc_pid macroengine.tmp run execute if entity @s[tag=macroengine.admin] run return 1

$execute as @a if score @s macroengine.pid = $pc_pid macroengine.tmp run execute if entity @s[tag=perm.$(perm)] run return 1

execute as @a if score @s macroengine.pid = $pc_pid macroengine.tmp run playsound macroengine:perm.denied master @s ~ ~ ~ 1 1
$execute as @a if score @s macroengine.pid = $pc_pid macroengine.tmp run tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"text":"✘ ","color":"red"},{"text":"$(perm)","color":"yellow"},{"text":" ","color":"red"},{"translate":"macroengine.msg.no_perm","with":[""],"color":"red"}]
return 0
