# macroengine:api/color/validate [MACRO]
# Checks whether a color string is a known named color or a valid hex code.
#
# Named colors accepted:
#   black, dark_blue, dark_green, dark_aqua, dark_red, dark_purple,
#   gold, gray, dark_gray, blue, green, aqua, red, light_purple,
#   yellow, white
#
# Hex accepted: #RRGGBB format (stored as-is; format is not verified at
# mcfunction level — caller must supply a valid string).
#
# Input (macro args):
#   color — color string to validate (e.g. "red", "#FF5500")
#
# Output → macroengine:output result
#   1b = valid named color or hex-like string starting with #
#   0b = invalid / unrecognised
#
# Usage:
#   function macroengine:api/color/validate {color:"red"}
#   data get storage macroengine:output result
#
# Note: hex validation only checks that the value starts with "#".
# Full format validation (#RRGGBB) is not possible in mcfunction alone.

data modify storage macroengine:output result set value 0b
$data modify storage macroengine:engine _color_validate_tmp set value {color:"$(color)"}
function macroengine:core/internal/systems/color/validate_exec with storage macroengine:engine _color_validate_tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"color/validate ","color":"aqua"},{"text":"$(color)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
