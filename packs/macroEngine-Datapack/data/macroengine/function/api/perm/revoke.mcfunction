execute if entity @s unless entity @s[tag=macroengine.admin] run playsound macroengine:perm.denied master @s ~ ~ ~ 1 1
execute if entity @s unless entity @s[tag=macroengine.admin] run return run tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"text":"✘ ","color":"red"},{"translate":"macroengine.msg.permission_denied","color":"red"}]

$data remove storage macroengine:engine permissions.$(player).$(perm)

scoreboard players set $prv_pid macroengine.tmp 0
$execute store result score $prv_pid macroengine.tmp run data get storage macroengine:engine player_pids.$(player)
$execute as @a if score @s macroengine.pid = $prv_pid macroengine.tmp run tag @s remove perm.$(perm)
$advancement revoke @a[name=$(player),limit=1] only macroengine:api/perm/$(perm)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"perm/revoke ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(player)","color":"white"},{"text":" — ","color":"#555555"},{"text":"$(perm)","color":"aqua"},{"text":" revoked","color":"#555555"}]
