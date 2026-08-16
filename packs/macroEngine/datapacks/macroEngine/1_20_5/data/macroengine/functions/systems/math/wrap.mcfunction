$scoreboard players set $wrap_v macroengine.tmp $(value)
$scoreboard players set $wrap_min macroengine.tmp $(min)
$scoreboard players set $wrap_max macroengine.tmp $(max)

scoreboard players operation $wrap_r macroengine.tmp = $wrap_max macroengine.tmp
scoreboard players operation $wrap_r macroengine.tmp -= $wrap_min macroengine.tmp

execute if score $wrap_r macroengine.tmp matches ..0 run execute store result storage macroengine:output result int 1 run scoreboard players get $wrap_min macroengine.tmp
execute if score $wrap_r macroengine.tmp matches ..0 run return 0

scoreboard players operation $wrap_off macroengine.tmp = $wrap_v macroengine.tmp
scoreboard players operation $wrap_off macroengine.tmp -= $wrap_min macroengine.tmp

scoreboard players operation $wrap_off macroengine.tmp %= $wrap_r macroengine.tmp
execute if score $wrap_off macroengine.tmp matches ..-1 run scoreboard players operation $wrap_off macroengine.tmp += $wrap_r macroengine.tmp

scoreboard players operation $wrap_off macroengine.tmp += $wrap_min macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $wrap_off macroengine.tmp
