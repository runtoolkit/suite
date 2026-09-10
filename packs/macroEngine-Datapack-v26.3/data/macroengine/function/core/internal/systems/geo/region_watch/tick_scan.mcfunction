# macroengine:systems/geo/region_watch/internal/tick_scan
# Called directly from core/tick/queue_systems.mcfunction.
# If region_watches is non-empty, checks all regions for each player.

# Module toggle guard — skips this module when disabled via macroengine:api/toggle/geo/false
execute unless data storage macroengine:engine {modules:{geo:1b}} run return 0

execute unless data storage macroengine:engine region_watches run return 0

data modify storage macroengine:engine _rw_watch_list set from storage macroengine:engine region_watches
execute as @a run function macroengine:core/internal/systems/geo/region_watch/player_scan
data remove storage macroengine:engine _rw_watch_list
