execute unless function macro:debug/tools/utils/check_all run return run tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied.","color":"red"}]

$execute if entity @s[tag=macro.admin] run tag @a[nane=$(target),limit=1] remove macro.admin
$tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(NAME)","color":"white"},{"text":" removed from admins.","color":"green"}]
