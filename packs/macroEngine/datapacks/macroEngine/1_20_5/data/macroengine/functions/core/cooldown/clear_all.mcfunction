$data remove storage macroengine:engine cooldowns.$(player)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/clear_all ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(player)","color":"white"},{"text":" — all cooldowns cleared","color":"#555555"}]
