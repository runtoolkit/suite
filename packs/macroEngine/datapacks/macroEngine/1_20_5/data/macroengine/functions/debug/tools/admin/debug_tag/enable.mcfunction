# macroengine:debug/tools/admin/debug_tag/enable
# Turns auto_debug_tag back ON: every admin (macroengine.admin tag) is
# granted macroengine.debug automatically each tick (legacy default).

data modify storage macroengine:engine security.auto_debug_tag set value 1b
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"auto_debug_tag ","color":"white"},{"text":"enabled","color":"green"},{"text":" — admins get macroengine.debug automatically again.","color":"gray"}]
