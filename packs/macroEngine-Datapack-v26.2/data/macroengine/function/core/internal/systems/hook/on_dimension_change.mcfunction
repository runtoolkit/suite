# macroengine:systems/hook/internal/on_dimension_change
# @s = the triggering player
data modify storage macroengine:engine _hook_fire_tmp set value {event:"dimension_change"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
