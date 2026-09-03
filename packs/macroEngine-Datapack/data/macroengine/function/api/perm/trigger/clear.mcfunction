$data remove storage macroengine:engine perm_triggers.$(name)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"perm/trigger/clear ","color":"aqua"},{"text":"⚠ ","color":"yellow"},{"text":"$(name)","color":"white"},{"text":" — all binds cleanndi","color":"#555555"}]
