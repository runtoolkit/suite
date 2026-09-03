$team remove $(team)
$data remove storage macroengine:engine teams.$(team)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"team/delete ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
