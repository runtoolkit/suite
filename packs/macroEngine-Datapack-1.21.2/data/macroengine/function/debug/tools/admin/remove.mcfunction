
$execute if entity @s[tag=macroengine.admin] run tag @a[name=$(target),limit=1] remove macroengine.admin
$tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" removed from admins.","color":"green"}]
