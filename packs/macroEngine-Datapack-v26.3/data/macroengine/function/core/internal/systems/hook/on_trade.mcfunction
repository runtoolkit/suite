# macroengine:systems/hook/internal/on_trade
# @s = the triggering player
data modify storage macroengine:engine _hook_fire_tmp set value {event:"trade"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
