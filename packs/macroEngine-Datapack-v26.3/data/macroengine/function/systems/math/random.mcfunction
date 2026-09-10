$scoreboard players set $rnd_min macroengine.tmp $(min)
$scoreboard players set $rnd_max macroengine.tmp $(max)

scoreboard players operation $rnd_max macroengine.tmp -= $rnd_min macroengine.tmp
scoreboard players add $rnd_max macroengine.tmp 1

execute if data storage macroengine:engine _rng_state run execute store result score $rnd macroengine.tmp run data get storage macroengine:engine _rng_state
execute unless data storage macroengine:engine _rng_state run execute store result score $rnd macroengine.tmp run scoreboard players get $epoch macroengine.time
execute unless data storage macroengine:engine _rng_state run scoreboard players add $rnd macroengine.tmp 57005

scoreboard players set $rnd_tick macroengine.tmp 31
execute store result score $rnd_t macroengine.tmp run scoreboard players get $tick macroengine.tmp
scoreboard players operation $rnd_t macroengine.tmp *= $rnd_tick macroengine.tmp
scoreboard players operation $rnd macroengine.tmp += $rnd_t macroengine.tmp

scoreboard players set $rnd_a macroengine.tmp 1664525
scoreboard players operation $rnd macroengine.tmp *= $rnd_a macroengine.tmp
scoreboard players add $rnd macroengine.tmp 1013904223

execute store result storage macroengine:engine _rng_state int 1 run scoreboard players get $rnd macroengine.tmp

execute if score $rnd macroengine.tmp matches -2147483648 run scoreboard players set $rnd macroengine.tmp 2147483647
execute if score $rnd macroengine.tmp matches ..-1 run scoreboard players set $rnd_neg macroengine.tmp -1
execute if score $rnd macroengine.tmp matches ..-1 run scoreboard players operation $rnd macroengine.tmp *= $rnd_neg macroengine.tmp

scoreboard players operation $rnd macroengine.tmp %= $rnd_max macroengine.tmp
execute if score $rnd macroengine.tmp matches ..-1 run scoreboard players operation $rnd macroengine.tmp += $rnd_max macroengine.tmp
scoreboard players operation $rnd macroengine.tmp += $rnd_min macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $rnd macroengine.tmp
