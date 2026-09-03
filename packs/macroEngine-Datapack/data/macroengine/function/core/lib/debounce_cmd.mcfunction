$execute if data storage macroengine:engine schedules.$(key) run return 0

function macroengine:core/lib/schedule_cmd with storage macroengine:input {}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/debounce_cmd ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
