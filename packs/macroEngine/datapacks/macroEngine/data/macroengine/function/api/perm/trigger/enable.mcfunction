scoreboard players set $pte_pid macroengine.tmp 0
$execute store result score $pte_pid macroengine.tmp run data get storage macroengine:engine player_pids.$(player)
execute if score $pte_pid macroengine.tmp matches 0 run return 0

data modify storage macroengine:engine _pte_tmp set value {result:0b}
execute as @a if score @s macroengine.pid = $pte_pid macroengine.tmp run execute if entity @s[tag=macroengine.admin] run data modify storage macroengine:engine _pte_tmp.result set value 1b
$execute if data storage macroengine:engine permissions.$(player).$(perm) run data modify storage macroengine:engine _pte_tmp.result set value 1b

$execute if data storage macroengine:engine _pte_tmp{result:0b} run execute as @a if score @s macroengine.pid = $pte_pid macroengine.tmp run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"$(perm)","color":"yellow"},{"text":" — you don't have this permission.","color":"red"}]
execute if data storage macroengine:engine _pte_tmp{result:0b} run return 0

$execute as @a if score @s macroengine.pid = $pte_pid macroengine.tmp run scoreboard players enable @s $(name)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"perm/trigger/enable ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(player)","color":"white"},{"text":" — ","color":"#555555"},{"text":"$(name)","color":"aqua"},{"text":" enabled","color":"#555555"}]
data remove storage macroengine:engine _pte_tmp
