execute unless function macro:debug/tools/utils/check_all run return 0

$advancement grant @a[name=$(player),limit=1] only $(advancement)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/advancement_grant ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(advancement)","color":"aqua"}]
