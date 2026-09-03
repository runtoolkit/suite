# macroengine:systems/hook/unbind_all
# Clears all hook binds.

data modify storage macroengine:engine hook_binds set value []

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"hook/unbind_all ","color":"aqua"},{"text":"⚠ all hook binds cleared","color":"yellow"}]
