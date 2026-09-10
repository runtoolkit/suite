execute if score $rn_i macroengine.tmp >= $rn_n macroengine.tmp run return 0

execute store result score $repeat_i macroengine.tmp run scoreboard players get $rn_i macroengine.tmp
function macroengine:core/internal/core/lib/repeat_n_call with storage macroengine:engine {}
scoreboard players add $rn_i macroengine.tmp 1
function macroengine:core/internal/core/lib/repeat_n_loop
