$scoreboard players set $lc_a macroengine.tmp $(a)
$scoreboard players set $lc_b macroengine.tmp $(b)
$scoreboard players set $lc_t macroengine.tmp $(t)

execute if score $lc_t macroengine.tmp matches ..-1 run scoreboard players set $lc_t macroengine.tmp 0
scoreboard players set $lc_100 macroengine.tmp 100
execute if score $lc_t macroengine.tmp > $lc_100 macroengine.tmp run scoreboard players operation $lc_t macroengine.tmp = $lc_100 macroengine.tmp

scoreboard players operation $lc_r macroengine.tmp = $lc_b macroengine.tmp
scoreboard players operation $lc_r macroengine.tmp -= $lc_a macroengine.tmp

scoreboard players operation $lc_r macroengine.tmp *= $lc_t macroengine.tmp
scoreboard players operation $lc_r macroengine.tmp /= $lc_100 macroengine.tmp
scoreboard players operation $lc_r macroengine.tmp += $lc_a macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $lc_r macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/lerp_clamped ","color":"aqua"},{"text":"a=","color":"#555555"},{"text":"$(a)","color":"white"},{"text":" b=","color":"#555555"},{"text":"$(b)","color":"white"},{"text":" t=","color":"#555555"},{"text":"$(t)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
