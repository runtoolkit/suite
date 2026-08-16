# macroengine:systems/geo/region_watch/internal/unregister_filter
# Iterates _rw_src list.
# Copies entries whose id does not match _rw_unbind_id to _rw_new.

execute unless data storage macroengine:engine _rw_src[0] run return 0

data modify storage macroengine:engine _rw_cur set from storage macroengine:engine _rw_src[0]
data remove storage macroengine:engine _rw_src[0]

function macroengine:core/internal/systems/geo/region_watch/unregister_check with storage macroengine:engine _rw_cur

function macroengine:core/internal/systems/geo/region_watch/unregister_filter