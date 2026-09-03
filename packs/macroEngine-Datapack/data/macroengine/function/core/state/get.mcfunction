data remove storage macroengine:output result
$execute if data storage macroengine:engine states.$(player) run data modify storage macroengine:output result set from storage macroengine:engine states.$(player)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"state/get ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
