$execute store result storage macroengine:engine config.$(key) int 1 run scoreboard players set $cfg_tmp macroengine.tmp $(value)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"config/set_int ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
