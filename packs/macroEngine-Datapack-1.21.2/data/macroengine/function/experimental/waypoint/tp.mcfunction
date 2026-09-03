# macroengine:experimental/waypoint/tp [MACRO]
# Teleports the caller to a stored waypoint (same-dimension only —
# does not cross-dimension teleport, kept out of scope for this
# first experimental pass).
#
# Usage:  function macroengine:experimental/waypoint/tp {name:"base"}
# Caller: any player

execute unless data storage macroengine:engine flags.experimental{waypoint:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/waypoint is disabled.","color":"red"}]
execute unless data storage macroengine:engine flags.experimental{waypoint:1b} run return 0

$execute unless data storage macroengine:engine waypoints."$(name)" run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"no waypoint named ","color":"red"},{"text":"$(name)","color":"aqua"}]
$execute unless data storage macroengine:engine waypoints."$(name)" run return 0

$tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"teleporting to ","color":"gray"},{"text":"$(name)","color":"aqua"}]
$function macroengine:core/internal/experimental/waypoint/do_tp with storage macroengine:engine waypoints.$(name)
