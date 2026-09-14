# macroengine:core/internal/load/force_apply
# Runs after gate confirmation (or immediately if gates are disabled).
# Actually performs the force re-init: drops the loaded flag and
# re-runs the full init pipeline, discarding any live engine state
# that macroengine:core/internal/load/all's "unless data" guards would otherwise preserve.

data remove storage macroengine:engine global.loaded
tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Force re-init...","color":"yellow"}]
function macroengine:core/internal/load/all
