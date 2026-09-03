$data remove storage macroengine:engine cooldowns.$(player).$(key)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/clear ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" cleared","color":"#555555"}]
