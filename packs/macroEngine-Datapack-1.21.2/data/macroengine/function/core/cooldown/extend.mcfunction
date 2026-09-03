execute store result score $ce_base macroengine.tmp run scoreboard players get $epoch macroengine.time
scoreboard players operation $ce_exp macroengine.tmp = $ce_base macroengine.tmp

$execute if data storage macroengine:engine cooldowns.$(player).$(key) run execute store result score $ce_exp macroengine.tmp run data get storage macroengine:engine cooldowns.$(player).$(key)

execute if score $ce_exp macroengine.tmp <= $ce_base macroengine.tmp run scoreboard players operation $ce_exp macroengine.tmp = $ce_base macroengine.tmp

$scoreboard players set $ce_amt macroengine.tmp $(amount)
scoreboard players operation $ce_exp macroengine.tmp += $ce_amt macroengine.tmp

$execute store result storage macroengine:engine cooldowns.$(player).$(key) int 1 run scoreboard players get $ce_exp macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/extend ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" +$(amount)t","color":"green"},{"text":" → exp=","color":"#555555"},{"score":{"name":"$ce_exp","objective":"macroengine.tmp"},"color":"yellow"}]
