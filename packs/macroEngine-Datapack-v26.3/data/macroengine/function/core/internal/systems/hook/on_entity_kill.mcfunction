# macroengine:systems/hook/internal/on_entity_kill
# @s = player who triggered the event
data modify storage macroengine:engine _hook_fire_tmp set value {event:"entity_kill"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
