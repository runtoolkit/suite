scoreboard players set $thr_go macroengine.tmp 1

$execute if data storage macroengine:engine throttle.$(key) run execute store result score $thr_exp macroengine.tmp run data get storage macroengine:engine throttle.$(key)
execute store result score $thr_now macroengine.tmp run scoreboard players get $epoch macroengine.time
$execute if data storage macroengine:engine throttle.$(key) run execute if score $thr_now macroengine.tmp < $thr_exp macroengine.tmp run scoreboard players set $thr_go macroengine.tmp 0

$execute if score $thr_go macroengine.tmp matches 0 run execute as @a[tag=macroengine.debug] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/throttle ","color":"aqua"},{"text":"SKIP ","color":"#FF5555"},{"text":"$(key)","color":"aqua"},{"text":" — throttled, skipped","color":"#555555"}]
execute if score $thr_go macroengine.tmp matches 0 run return 0

$scoreboard players set $thr_int macroengine.tmp $(interval)
scoreboard players operation $thr_now macroengine.tmp += $thr_int macroengine.tmp
$execute store result storage macroengine:engine throttle.$(key) int 1 run scoreboard players get $thr_now macroengine.tmp

function macroengine:core/lib/queue_add with storage macroengine:input {}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/throttle ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
