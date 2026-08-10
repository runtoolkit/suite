# macro:systems/security/menu
# Security status panel — part of #macro:admin/menu.
# 1.21.6+ overlay replaces this with an interactive dialog.
# Requires: ame.perm_level >= security.admin_min_level
execute unless function macro:debug/tools/utils/perm_check run return 0
tellraw @s ["",{"text":"─── AME Security ─────────────────────","color":"#00AAAA","bold":true}]
tellraw @s ["",{"text":"  Version         ","color":"gray"},{"storage":"macro:engine","nbt":"global.version","color":"aqua"}]
tellraw @s ["",{"text":"  sandbox         ","color":"gray"},{"storage":"macro:engine","nbt":"sandbox","color":"gold"}]
tellraw @s ["",{"text":"  trust_players   ","color":"gray"},{"storage":"macro:engine","nbt":"security.trust_players","color":"gold"}]
tellraw @s ["",{"text":"  cmd_min_level   ","color":"gray"},{"storage":"macro:engine","nbt":"security.cmd_min_level","color":"green"}]
tellraw @s ["",{"text":"  sandbox_level   ","color":"gray"},{"storage":"macro:engine","nbt":"security.sandbox_cmd_min_level","color":"green"}]
tellraw @s ["",{"text":"  admin_min_level ","color":"gray"},{"storage":"macro:engine","nbt":"security.admin_min_level","color":"green"}]
tellraw @s ["",{"text":"  admin_override  ","color":"gray"},{"storage":"macro:engine","nbt":"security.admin_can_override","color":"gold"}]
tellraw @s ["",{"text":"  Your level      ","color":"gray"},{"score":{"name":"@s","objective":"ame.perm_level"},"color":"yellow","bold":true}]
tellraw @s ["",{"text":"  [sandbox on] ","color":"green","click_event":{"action":"suggest_command","command":"/data modify storage macro:engine sandbox set value 1b"},"hover_event":{"action":"show_text","value":"Suggest: enable sandbox"}},{"text":"[sandbox off]","color":"red","click_event":{"action":"suggest_command","command":"/data modify storage macro:engine sandbox set value 0b"},"hover_event":{"action":"show_text","value":"Suggest: disable sandbox"}}]
