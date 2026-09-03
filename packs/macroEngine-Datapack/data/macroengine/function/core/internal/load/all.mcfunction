# macroengine:core/internal/load/all — full init pipeline (no fork / rt_origin / confirm gates)

tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Starting macroEngine...","color":"gray"}]

# forceload classic marker chunk (legacy features)
forceload add -30000000 1600

function macroengine:core/internal/load/loader/scoreboards
function macroengine:core/internal/load/loader/storages
function macroengine:core/internal/load/loader/other

# Re-apply config after storages (storages may reset defaults)
function macroengine:config

# Load version-specific backports (new → old compatibility layer)
# Overlays override macroengine:backport/* with legacy implementations
function macroengine:backport/load

data modify storage macroengine:engine global.loaded set value 1b

schedule function macroengine:core/internal/load/final 2s
