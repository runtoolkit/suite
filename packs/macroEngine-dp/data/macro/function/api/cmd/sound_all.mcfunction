execute unless function macro:debug/tools/utils/check_all run return 0

$playsound $(sound) master @a ~ ~ ~ $(volume) $(pitch)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/sound_all ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(sound)","color":"aqua"}]
