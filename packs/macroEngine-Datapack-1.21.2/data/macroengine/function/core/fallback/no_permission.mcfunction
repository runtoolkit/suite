# macroengine:core/fallback/no_permission
# Called when executor's macroengine.perm_level < security.cmd_min_level (or sandbox threshold).

data modify storage macroengine:engine _log_add_tmp.message set value "[Fallback] no_permission — macroengine.perm_level below required threshold"
data modify storage macroengine:engine _log_add_tmp.level set value "WARN"
data modify storage macroengine:engine _log_add_tmp.color set value "yellow"
execute if score #macroengine.log_level macroengine.log_level matches 2.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
data remove storage macroengine:engine _log_add_tmp.message
data remove storage macroengine:engine _log_add_tmp.level
data remove storage macroengine:engine _log_add_tmp.color

# Notify caller
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Permission denied. Your ","color":"red"},{"text":"macroengine.perm_level","color":"aqua"},{"text":" is insufficient.","color":"red"}]

# Notify debug admins
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"NO_PERM ","color":"yellow","bold":true},{"selector":"@s","color":"gold"},{"text":" — perm_level below threshold","color":"yellow"}]

data modify storage macroengine:output fallback set value {triggered:1b,reason:"no_permission"}
return 0
