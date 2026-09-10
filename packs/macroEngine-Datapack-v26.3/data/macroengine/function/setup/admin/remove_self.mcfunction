# macroengine:setup/admin/remove_self [INTERNAL — called by the macroengine:setup_screen dialog]
tag @s remove macroengine.admin
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},"Removed from admin list."]
