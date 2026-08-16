# macroengine_load:gate/no
# Cancels the pending gated action without running it.
# Only players with macroengine.admin may call this directly (same trust
# boundary as gate/yes).

execute unless entity @s[tag=macroengine.admin] run return 0
execute unless data storage macroengine:engine pending_gate run return 0

schedule clear macroengine_load:gate/timeout

tellraw @a[tag=macroengine.admin] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Cancelled: ","color":"gray"},{"nbt":"pending_gate.label","storage":"macroengine:engine","color":"white"}]

data remove storage macroengine:engine pending_gate
