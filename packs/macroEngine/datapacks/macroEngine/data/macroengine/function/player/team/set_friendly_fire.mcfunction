$team modify $(team) friendlyFire $(value)
$data modify storage macroengine:engine teams.$(team).friendly_fire set value "$(value)"
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"team/set_friendly_fire ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"}]
