# macroengine:debug/tools/trigger — single-call dispatch layer (EC-style).
# Does not require EventCore; uses AME's own macroengine:api/cmd/* functions.
#
# Usage:
# function macroengine:debug/tools/trigger {type:"<type>", data:{...}}
# function macroengine:debug/tools/trigger {type:"<type>", data:{...}, config:{silent:1}}
#
# config:{silent:1} → suppress debug tellraw.

data modify storage macroengine:engine tools_trigger.data.uuid set from entity @s UUID

$data modify storage macroengine:engine tools_trigger.type set value "$(type)"
$data modify storage macroengine:engine tools_trigger.data set value $(data)

# Execute action
function macroengine:core/internal/debug/tools/trigger/dispatch

# Debug message
$execute if data storage macroengine:engine tools_trigger.config{silent:1} run tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"tools/trigger/execute ","color":"aqua"},{"text":"► ","color":"yellow"},{"text":"$(type)","color":"white"}]
execute if data storage macroengine:engine tools_trigger.config{silent:0} run function macroengine:core/tick/disabled

# Remove 'macroengine:engine tools_trigger' storage
data remove storage macroengine:engine tools_trigger
