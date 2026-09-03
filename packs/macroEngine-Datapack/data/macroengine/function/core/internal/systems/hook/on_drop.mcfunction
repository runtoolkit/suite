# macroengine:systems/hook/internal/on_drop
data modify storage macroengine:engine _hook_fire_tmp set value {event:"drop_item"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
