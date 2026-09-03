# macroengine:systems/hook/internal/on_eat_fire
# @s = the eating player
data modify storage macroengine:engine _hook_fire_tmp set value {event:"eat"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
