# macroengine:systems/hook/internal/on_hero_of_the_village
# @s = player who triggered the event
data modify storage macroengine:engine _hook_fire_tmp set value {event:"hero_of_the_village"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp
