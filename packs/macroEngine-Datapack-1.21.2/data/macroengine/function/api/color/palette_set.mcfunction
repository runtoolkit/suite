# macroengine:api/color/palette_set [MACRO]
# Registers a named color alias in the runtime palette.
# Existing key is overwritten.
#
# Input (macro args):
#   key   — alias name (e.g. "brand", "danger", "success")
#   value — color value (named or hex, e.g. "#00AAAA", "red")
#
# Output → none
#
# Usage:
#   function macroengine:api/color/palette_set {key:"brand",value:"#00AAAA"}
#   function macroengine:api/color/palette_set {key:"danger",value:"red"}


execute unless data storage macroengine:engine color.palette run data modify storage macroengine:engine color.palette set value {}
$data modify storage macroengine:engine color.palette.$(key) set value "$(value)"
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"color/palette_set ","color":"aqua"},{"text":"$(key)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(value)","color":"green"}]
