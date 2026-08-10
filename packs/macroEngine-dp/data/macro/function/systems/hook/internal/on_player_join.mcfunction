# macro:systems/hook/internal/on_player_join
# @s = the triggering player
data modify storage macro:engine _hook_fire_tmp set value {event:"player_join"}
function macro:systems/hook/internal/fire with storage macro:engine _hook_fire_tmp
data remove storage macro:engine _hook_fire_tmp

# Event bus
function #macro:events/on_join

# Initialize player data and assign macro.pid
# get_name populates macro:names temp.NAME; init_from_name relays it to player/init
function macro:player/get_name
function macro:player/internal/init_from_name with storage macro:names temp
