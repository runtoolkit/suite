# macroengine_load:load/all — full init pipeline (no fork / rt_origin / confirm gates)

tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Starting macroEngine...","color":"gray"}]

# forceload classic marker chunk (legacy features)
forceload add -30000000 1600

function macroengine_load:loader/scoreboards
function macroengine_load:loader/storages
function macroengine_load:loader/other

# Re-apply config after storages (storages may reset defaults)
function macroengine:config

data modify storage macroengine:engine global.loaded set value 1b

schedule function macroengine_load:load/final 2s
