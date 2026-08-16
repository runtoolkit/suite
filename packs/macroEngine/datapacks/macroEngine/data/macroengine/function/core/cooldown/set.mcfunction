$scoreboard players set $cd_dur macroengine.tmp $(duration)
execute store result score $cd_now macroengine.tmp run scoreboard players get $epoch macroengine.time
scoreboard players operation $cd_now macroengine.tmp += $cd_dur macroengine.tmp
$execute store result storage macroengine:engine cooldowns.$(player).$(key) int 1 run scoreboard players get $cd_now macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/set ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" for ","color":"#555555"},{"text":"$(duration)","color":"green"},{"text":"t","color":"#555555"}]
