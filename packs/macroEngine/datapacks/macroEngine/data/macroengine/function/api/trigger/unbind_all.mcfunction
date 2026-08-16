data modify storage macroengine:engine trigger_binds set value []
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"trigger/unbind_all ","color":"aqua"},{"text":"⚠ ","color":"yellow"},{"text":"all trigger binds cleared","color":"#555555"}]
