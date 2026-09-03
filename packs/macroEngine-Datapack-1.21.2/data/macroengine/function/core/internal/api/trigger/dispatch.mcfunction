scoreboard players operation $tc_player macroengine.tmp = @s macroengine_action

scoreboard players set @s macroengine_action 0
scoreboard players enable @s macroengine_action

execute unless data storage macroengine:engine trigger_binds[0] run return 0

data modify storage macroengine:engine _tc_binds set from storage macroengine:engine trigger_binds

function macroengine:core/internal/api/trigger/check_next
data remove storage macroengine:engine _tc_binds
data remove storage macroengine:engine _tc_current
