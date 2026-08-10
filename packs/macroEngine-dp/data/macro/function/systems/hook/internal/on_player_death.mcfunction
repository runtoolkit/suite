# macro:systems/hook/internal/on_player_death
# @s = the triggering player
data modify storage macro:engine _hook_fire_tmp set value {event:"player_death"}
function macro:systems/hook/internal/fire with storage macro:engine _hook_fire_tmp
data remove storage macro:engine _hook_fire_tmp

# Event bus
function #macro:events/on_death
