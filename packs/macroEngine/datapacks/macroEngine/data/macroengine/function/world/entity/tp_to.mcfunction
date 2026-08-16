$tp @e[type=$(type),tag=$(tag)] $(x) $(y) $(z)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"entity/tp_to ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
