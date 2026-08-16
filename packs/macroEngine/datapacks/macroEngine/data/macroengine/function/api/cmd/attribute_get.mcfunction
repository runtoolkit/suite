
$execute store result storage macroengine:output result double 1 run attribute @a[name=$(player),limit=1] $(attribute) get
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/attribute_get ","color":"aqua"},{"text":"$(player)","color":"white"}]
