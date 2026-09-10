# macroengine:systems/hook/internal/on_sprint_stop
# @s = player who triggered the event
data modify storage macroengine:engine _hook_fire_tmp set value {event:"sprint_stop"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
