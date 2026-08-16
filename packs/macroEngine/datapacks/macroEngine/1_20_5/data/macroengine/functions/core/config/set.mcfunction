$data modify storage macroengine:engine config.$(key) set value "$(value)"
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"config/set ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
