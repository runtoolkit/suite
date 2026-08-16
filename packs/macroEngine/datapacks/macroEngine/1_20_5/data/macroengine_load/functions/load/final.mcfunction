data modify storage macroengine:engine global.version set value "v6.0.2"
function #load:_private/load
scoreboard players set #runtoolkit.packs.macroengine.version macroengine.meta 602

tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"macroEngine v6.0.2 loaded.","color":"green"}]