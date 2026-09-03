
data modify storage macroengine:output result set value 0b
$execute if entity @a[name=$(player),limit=1,advancements={$(advancement)=true}] run data modify storage macroengine:output result set value 1b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/advancement_check ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(advancement)","color":"aqua"}]
