# macroengine:systems/hook/internal/on_player_join
# @s = the triggering player
data modify storage macroengine:engine _hook_fire_tmp set value {event:"player_join"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp

# Event bus
function #macroengine:events/on_join

# Initialize player data and assign macroengine.pid
# get_name populates macroengine:names temp.NAME; init_from_name relays it to player/init
function macroengine:player/get_name
function macroengine:core/internal/player/init_from_name with storage macroengine:names temp
