execute if score $lg2_v macroengine.tmp matches ..1 run return 0

scoreboard players add $lg2_r macroengine.tmp 1
scoreboard players operation $lg2_v macroengine.tmp /= $lg2_2 macroengine.tmp

function macroengine:core/internal/systems/math/log2_loop
