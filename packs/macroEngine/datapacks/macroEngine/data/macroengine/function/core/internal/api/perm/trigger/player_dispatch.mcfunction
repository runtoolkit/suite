$scoreboard players operation $ptd_val macroengine.tmp = @s $(name)

$scoreboard players set @s $(name) 0
$scoreboard players enable @s $(name)

$execute unless data storage macroengine:engine perm_triggers.$(name)[0] run return 0

$data modify storage macroengine:engine _ptd_binds set from storage macroengine:engine perm_triggers.$(name)

function macroengine:core/internal/api/perm/trigger/check_bind
data remove storage macroengine:engine _ptd_binds
data remove storage macroengine:engine _ptd_current
