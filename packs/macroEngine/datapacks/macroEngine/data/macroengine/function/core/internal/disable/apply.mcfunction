# macroengine:core/internal/disable/apply
# The actual disable logic, run either directly (gates off) or after
# gate confirmation (gates on, the default).
function macroengine_load:core/internal/load/cleanup
datapack disable "file/macroengine.zip"
datapack disable "file/macroengine"
scoreboard players set #runtoolkit.packs.macroengine.version macroengine.meta 0
tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"macroengine disabled.","color":"red"}]
