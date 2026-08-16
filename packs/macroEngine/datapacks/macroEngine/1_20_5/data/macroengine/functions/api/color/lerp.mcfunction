# macroengine:api/color/lerp [MACRO]
# Looks up a precomputed lerp step from a named gradient table.
# Gradients are registered via macroengine:api/color/gradient_set.
#
# This is NOT a real-time RGB interpolator — mcfunction cannot do
# per-channel arithmetic at runtime. Instead, callers pre-register
# a gradient as an ordered list of hex strings and this function
# returns the entry at the given step index.
#
# Input (macro args):
# gradient — gradient name registered via gradient_set
# step — integer index into the gradient list (0-based)
#
# Output → macroengine:output result
# The color string at that step, or "" if out of range.
#
# Usage:
# # Register once (e.g. at load):
# function macroengine:api/color/gradient_set {name:"sunset",\
# colors:["#FF0000","#FF5500","#FFAA00","#FFD700","#FFFF00"]}
#
# # Retrieve at runtime:
# function macroengine:api/color/lerp {gradient:"sunset",step:2}
# # → macroengine:output result = "#FFAA00"

data modify storage macroengine:output result set value ""
$data modify storage macroengine:engine _color_lerp_tmp set value {gradient:"$(gradient)",step:$(step)}
$execute if data storage macroengine:engine color.gradients.$(gradient) run function macroengine:core/internal/systems/color/lerp_exec with storage macroengine:engine _color_lerp_tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"color/lerp ","color":"aqua"},{"text":"$(gradient)[$(step)]","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
