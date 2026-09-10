# macroengine:systems/hook/internal/on_player_death
# @s = the triggering player
data modify storage macroengine:engine _hook_fire_tmp set value {event:"player_death"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp

# Event bus
function #macroengine:events/on_death
