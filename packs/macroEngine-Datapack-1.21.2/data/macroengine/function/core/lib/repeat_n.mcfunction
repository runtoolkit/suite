$scoreboard players set $rn_n macroengine.tmp $(n)
scoreboard players set $rn_i macroengine.tmp 0

execute if score $rn_n macroengine.tmp matches ..0 run return 0

$data modify storage macroengine:engine _rn_func set value "$(func)"
function macroengine:core/internal/core/lib/repeat_n_loop
data remove storage macroengine:engine _rn_func
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/repeat_n ","color":"aqua"},{"text":"$(func) × $(n)","color":"aqua"}]
