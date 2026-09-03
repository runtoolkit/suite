execute if entity @s[tag=macroengine.admin] run function macroengine:core/internal/api/perm/trigger/exec with storage macroengine:engine _ptd_current

$execute unless entity @s[tag=macroengine.admin] if entity @s[tag=perm.$(perm)] run function macroengine:core/internal/api/perm/trigger/exec with storage macroengine:engine _ptd_current

$execute unless entity @s[tag=macroengine.admin] unless entity @s[tag=perm.$(perm)] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"$(perm)","color":"yellow"},{"text":" — you don't have this permission.","color":"red"}]
