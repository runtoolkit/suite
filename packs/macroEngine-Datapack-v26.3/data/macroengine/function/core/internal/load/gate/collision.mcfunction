# macroengine:core/internal/load/gate/collision
# A gate request came in while another was already pending. The original
# request keeps priority; this collision is logged instead of silently
# dropped.

data modify storage macroengine:engine _log_add_tmp.message set value "[Gate] Collision: a gate request was dropped because one was already pending"
data modify storage macroengine:engine _log_add_tmp.level set value "WARN"
data modify storage macroengine:engine _log_add_tmp.color set value "yellow"
execute if score #macroengine.log_level macroengine.log_level matches 1.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
