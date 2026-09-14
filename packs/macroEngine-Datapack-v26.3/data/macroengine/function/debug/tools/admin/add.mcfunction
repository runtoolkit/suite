
$execute if entity @s[tag=macroengine.admin] run tag @a[name=$(target),limit=1] add macroengine.admin
$tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" added as admin.","color":"green"}]
