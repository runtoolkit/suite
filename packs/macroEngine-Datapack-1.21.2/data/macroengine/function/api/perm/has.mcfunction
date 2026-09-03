data modify storage macroengine:output result set value 0b

scoreboard players set $ph_pid macroengine.tmp 0
$execute store result score $ph_pid macroengine.tmp run data get storage macroengine:engine player_pids.$(player)

execute as @a if score @s macroengine.pid = $ph_pid macroengine.tmp run execute if entity @s[tag=macroengine.admin] run data modify storage macroengine:output result set value 1b
$execute as @a if score @s macroengine.pid = $ph_pid macroengine.tmp run execute if entity @s[tag=perm.$(perm)] run data modify storage macroengine:output result set value 1b

$execute if data storage macroengine:engine permissions.$(player).$(perm) run data modify storage macroengine:output result set value 1b

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"perm/has ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(perm)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
