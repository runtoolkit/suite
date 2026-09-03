# macroengine:setup/open_screen [INTERNAL — called by macroengine:setup]
# When "macroengine:setup" runs, this prints a clickable management menu.
# BACKPORT NOTE (1.21.2): the original pack (26.x) opened this as a native
# `dialog show` screen (minecraft:multi_action). The dialog system does not
# exist in 1.21.2 (added in 1.21.6, pack format 80). Reimplemented here as a
# clickable tellraw menu using clickEvent{action:"run_command"} — same
# actions, chat UI instead of a screen.
tellraw @s ["",{"text":"═══════ ","color":"dark_gray"},{"text":"macroEngine — Setup","color":"aqua","bold":true},{"text":" ═══════","color":"dark_gray"}]
tellraw @s {"text":"macroEngine v6.1.0 started. Choose an action:","color":"gray"}
tellraw @s ["",{"text":"[Add Admin] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:setup/admin/add_self"},"hoverEvent":{"action":"show_text","value":"Marks yourself as an admin."}},{"text":"[Remove Admin] ","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:setup/admin/remove_self"},"hoverEvent":{"action":"show_text","value":"Removes yourself from the admin list."}},{"text":"[Admin List] ","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:debug/tools/admin/list"}},{"text":"[Force Reload] ","color":"gold","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:core/internal/load/force"},"hoverEvent":{"action":"show_text","value":"Requires confirmation — resets current session data."}},{"text":"[Close]","color":"white","clickEvent":{"action":"run_command","value":"/function macroengine:setup/close_screen"}}]
