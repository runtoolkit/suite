$execute unless data storage macroengine:engine events.$(event) run return 0

$data modify storage macroengine:engine _uro.event set value "$(event)"
$data modify storage macroengine:engine _uro.func set value "$(func)"
$data modify storage macroengine:engine _uro.src set from storage macroengine:engine events.$(event)

$data remove storage macroengine:engine events.$(event)

execute if data storage macroengine:engine _uro.src[0] run function macroengine:core/internal/events/uro_loop

data remove storage macroengine:engine _uro
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"event/unregister_one ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]