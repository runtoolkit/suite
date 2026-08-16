# macroengine:api/color/palette_delete [MACRO]
# Removes a color alias from the runtime palette.
#
# Input (macro args):
# key — alias name to remove
#
# Output → none
#
# Usage:
# function macroengine:api/color/palette_delete {key:"brand"}

$data remove storage macroengine:engine color.palette.$(key)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"color/palette_delete ","color":"aqua"},{"text":"$(key)","color":"white"}]
