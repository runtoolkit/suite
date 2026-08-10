# macro:systems/hook/internal/on_trade
# @s = the triggering player
data modify storage macro:engine _hook_fire_tmp set value {event:"trade"}
function macro:systems/hook/internal/fire with storage macro:engine _hook_fire_tmp
data remove storage macro:engine _hook_fire_tmp
