# macro:systems/hook/internal/on_level_up
# @s = the triggering player
data modify storage macro:engine _hook_fire_tmp set value {event:"level_up"}
function macro:systems/hook/internal/fire with storage macro:engine _hook_fire_tmp
data remove storage macro:engine _hook_fire_tmp
