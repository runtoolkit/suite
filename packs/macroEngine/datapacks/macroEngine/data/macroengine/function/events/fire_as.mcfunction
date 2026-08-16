$data modify storage macroengine:engine event_context.player set value "$(player)"

function macroengine:events/fire with storage macroengine:input {}

data remove storage macroengine:engine event_context.player

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"event/fire_as ","color":"aqua"},{"text":"$(event)","color":"aqua"},{"text":" as ","color":"#555555"},{"text":"$(player)","color":"white"}]