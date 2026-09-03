# macroengine:core/internal/load/gate/toggle/enable
# Re-enables the gate system (macroengine:engine sandbox -> 1b). No
# confirmation needed — turning the safety net back on is always safe.

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine sandbox set value 1b
data modify storage macroengine:engine config.sandbox set value 1b
tellraw @a[tag=macroengine.admin] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Gate confirmations re-enabled.","color":"green"}]
