$team modify $(team) color $(color)
$data modify storage macroengine:engine teams.$(team).color set value "$(color)"
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"team/set_color ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
