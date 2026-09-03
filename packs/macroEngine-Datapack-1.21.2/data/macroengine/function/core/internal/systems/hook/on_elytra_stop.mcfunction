# macroengine:systems/hook/internal/on_elytra_stop
# @s = player who triggered the event
data modify storage macroengine:engine _hook_fire_tmp set value {event:"elytra_stop"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
