$execute unless data storage macroengine:engine events.$(event) run return 0

$data modify storage macroengine:engine _event_tmp set from storage macroengine:engine events.$(event)

$execute as @a[name=$(player),limit=1] run function macroengine:core/internal/events/fire_next
data remove storage macroengine:engine _event_tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"event/fire_to_player ","color":"aqua"},{"text":"$(event) → $(player)","color":"aqua"}]