$execute if data storage macroengine:engine schedules.$(key) run return 0

function macroengine:core/lib/schedule with storage macroengine:input {}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/debounce ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
