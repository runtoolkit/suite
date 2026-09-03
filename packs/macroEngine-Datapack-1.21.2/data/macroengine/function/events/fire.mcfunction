$execute unless data storage macroengine:engine events.$(event) run execute as @a[tag=macroengine.debug] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"event/fire ","color":"aqua"},{"text":"SKIP ","color":"#FF5555"},{"text":"$(event)","color":"#AAAAAA"},{"text":" — no handlers registered","color":"#555555"}]
$execute unless data storage macroengine:engine events.$(event) run return 0

$data modify storage macroengine:engine _event_tmp set from storage macroengine:engine events.$(event)
execute if data storage macroengine:engine _event_tmp[0] run function macroengine:core/internal/events/fire_next
data remove storage macroengine:engine _event_tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"event/fire ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(event)","color":"aqua"}]