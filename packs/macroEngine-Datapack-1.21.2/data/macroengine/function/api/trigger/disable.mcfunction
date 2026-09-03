$scoreboard players reset $(player) macroengine_action
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"trigger/disable ","color":"aqua"},{"text":"· ","color":"#555555"},{"text":"$(player)","color":"white"},{"text":" — macroengine_action disabled","color":"#555555"}]
