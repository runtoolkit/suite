# macroengine:player/internal/init_online
# @s = online player
# Called once per online player during load to ensure pid is assigned.
# Uses get_name to fetch the display name, then delegates to init_from_nmacroengine.

function macroengine:player/get_name
function macroengine:core/internal/player/init_from_name with storage macroengine:names temp
