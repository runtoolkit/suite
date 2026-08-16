# macroengine:api/wand/unregister_all — Clears all wand binds.
data modify storage macroengine:engine wand_binds set value []
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"wand/unregister_all ","color":"aqua"},{"text":"⚠ all wand binds cleared","color":"yellow"}]
