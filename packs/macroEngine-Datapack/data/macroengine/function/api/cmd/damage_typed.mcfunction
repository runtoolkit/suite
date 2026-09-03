

$damage @a[name=$(player),limit=1] $(amount) $(damage_type)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/damage_typed ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(amount)","color":"aqua"}]
