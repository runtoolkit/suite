
$playsound $(sound) master @a ~ ~ ~ $(volume) $(pitch)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/sound_all ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(sound)","color":"aqua"}]
