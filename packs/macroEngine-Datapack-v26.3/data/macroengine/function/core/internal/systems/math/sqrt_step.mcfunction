scoreboard players operation $sqrt_mid macroengine.tmp = $sqrt_lo macroengine.tmp
scoreboard players operation $sqrt_mid macroengine.tmp += $sqrt_hi macroengine.tmp
scoreboard players set $sqrt_2 macroengine.tmp 2
scoreboard players operation $sqrt_mid macroengine.tmp /= $sqrt_2 macroengine.tmp

scoreboard players operation $sqrt_sq macroengine.tmp = $sqrt_mid macroengine.tmp
scoreboard players operation $sqrt_sq macroengine.tmp *= $sqrt_mid macroengine.tmp

execute if score $sqrt_sq macroengine.tmp <= $sqrt_n macroengine.tmp run scoreboard players operation $sqrt_lo macroengine.tmp = $sqrt_mid macroengine.tmp
execute unless score $sqrt_sq macroengine.tmp <= $sqrt_n macroengine.tmp run scoreboard players operation $sqrt_hi macroengine.tmp = $sqrt_mid macroengine.tmp

scoreboard players remove $sqrt_itr macroengine.tmp 1
execute if score $sqrt_itr macroengine.tmp matches 1.. run function macroengine:core/internal/systems/math/sqrt_step
