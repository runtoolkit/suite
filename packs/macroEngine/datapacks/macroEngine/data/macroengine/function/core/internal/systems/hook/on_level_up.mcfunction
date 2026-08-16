# macroengine:systems/hook/internal/on_level_up
# @s = the triggering player
data modify storage macroengine:engine _hook_fire_tmp set value {event:"level_up"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
