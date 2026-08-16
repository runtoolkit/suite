# macroengine:systems/hook/list
# Shows all registered hook binds to macroengine.debug players.

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Hook Binds ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━","color":"#555555"}]
execute unless data storage macroengine:engine hook_binds[0] run tellraw @a[tag=macroengine.debug] ["",{"text":" ","color":"#555555"},{"text":"(no hook binds)","color":"gray","italic":true}]
execute if data storage macroengine:engine hook_binds[0] run tellraw @a[tag=macroengine.debug] ["",{"text":" ","color":"#555555"},{"plain":true ,"storage":"macroengine:engine","nbt":"hook_binds","interpret":false,"color":"yellow"}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
