$scoreboard players set $ft_t macroengine.tmp $(ticks)

scoreboard players set $ft_20 macroengine.tmp 20
scoreboard players operation $ft_s macroengine.tmp = $ft_t macroengine.tmp
scoreboard players operation $ft_s macroengine.tmp /= $ft_20 macroengine.tmp

execute store result storage macroengine:output total_seconds int 1 run scoreboard players get $ft_s macroengine.tmp

scoreboard players set $ft_60 macroengine.tmp 60
scoreboard players operation $ft_m macroengine.tmp = $ft_s macroengine.tmp
scoreboard players operation $ft_m macroengine.tmp /= $ft_60 macroengine.tmp

scoreboard players operation $ft_s macroengine.tmp %= $ft_60 macroengine.tmp

execute store result storage macroengine:output minutes int 1 run scoreboard players get $ft_m macroengine.tmp
execute store result storage macroengine:output seconds int 1 run scoreboard players get $ft_s macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/format_ticks ","color":"aqua"},{"text":"$(ticks)t","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"minutes","color":"green"},{"text":"m ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"seconds","color":"green"},{"text":"s","color":"#555555"}]
