# macroengine:systems/hook/internal/on_using_item
# @s = player who triggered the event
data modify storage macroengine:engine _hook_fire_tmp set value {event:"using_item"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
