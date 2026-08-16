data modify storage macroengine:output result set value 1b

$execute if data storage macroengine:engine config.$(key) run data modify storage macroengine:output result set value 0b
$execute if data storage macroengine:engine config.$(key) run return 0

$data modify storage macroengine:engine config.$(key) set value "$(value)"
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"config/set_default ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
