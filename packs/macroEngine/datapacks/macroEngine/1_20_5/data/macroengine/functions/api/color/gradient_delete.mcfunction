# macroengine:api/color/gradient_delete [MACRO]
# Removes a named gradient from storage.
#
# Input (macro args):
# name — gradient name to remove
#
# Usage:
# function macroengine:api/color/gradient_delete {name:"health"}

$data remove storage macroengine:engine color.gradients.$(name)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"color/gradient_delete ","color":"aqua"},{"text":"$(name)","color":"white"}]
