# macroengine:systems/geo/region_watch/internal/region_loop
# @s = the player being checked
# Consumes _rw_iter list, calls check_region for each region.

execute unless data storage macroengine:engine _rw_iter[0] run return 0

data modify storage macroengine:engine _rw_cur set from storage macroengine:engine _rw_iter[0]
data remove storage macroengine:engine _rw_iter[0]

function macroengine:core/internal/systems/geo/region_watch/check_region with storage macroengine:engine _rw_cur

function macroengine:core/internal/systems/geo/region_watch/region_loop
