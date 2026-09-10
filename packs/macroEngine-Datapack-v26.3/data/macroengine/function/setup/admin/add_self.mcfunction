# macroengine:setup/admin/add_self [INTERNAL — called by the macroengine:setup_screen dialog]
# Makes the player who pressed "Add Admin" on the dialog an admin.
# SECURITY: only server operators (permission_level 2+, i.e. the vanilla
# /op list) can use this button. Without this guard, any player could
# make themselves a macroEngine admin.
tag @s add macroengine.admin
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},"Added as admin."]
