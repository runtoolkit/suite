# macroengine:core/internal/gate/toggle/disable_apply
# Runs after gate confirmation. Actually flips the sandbox flag off.

data modify storage macroengine:engine sandbox set value 0b
data modify storage macroengine:engine config.sandbox set value 0b
tellraw @a[tag=macroengine.admin] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Gate confirmations disabled. Dangerous commands will run immediately.","color":"red"}]
