# macro:systems/hook/internal/on_eat_fire
# @s = the eating player
data modify storage macro:engine _hook_fire_tmp set value {event:"eat"}
function macro:systems/hook/internal/fire with storage macro:engine _hook_fire_tmp
data remove storage macro:engine _hook_fire_tmp
