execute if score $pow_n macroengine.tmp matches ..0 run return 0
scoreboard players operation $pow_r macroengine.tmp *= $pow_a macroengine.tmp
scoreboard players remove $pow_n macroengine.tmp 1
function macroengine:core/internal/systems/math/pow_loop
