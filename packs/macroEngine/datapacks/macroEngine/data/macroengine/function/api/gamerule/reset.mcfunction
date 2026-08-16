# macroengine:api/gamerule/reset [MACRO]
# Removes a custom gamerule from engine storage entirely.
# Does NOT touch vanilla /gamerule — this is for macroengine-tracked rules only.
#
# INPUT (macro args via `with storage macroengine:input {}`):
#   $(rule) — rule name string
#
# EXAMPLE:
#   data modify storage macroengine:input rule set value "pvp_enabled"
#   function macroengine:api/gamerule/reset with storage macroengine:input {}


# Normalize
data modify storage macroengine_string:input replace.String set from storage macroengine:input rule
data modify storage macroengine_string:input replace.Find set value " "
data modify storage macroengine_string:input replace.Replace set value "_"
function macroengine_string:util/replace
data modify storage macroengine:input _gamerule_norm set from storage macroengine_string:output replace
data remove storage macroengine_string:input replace

function macroengine:core/internal/api/gamerule/remove with storage macroengine:input {}

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"gamerule/reset ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"gray","italic":true},{"text":" removed","color":"gray"}]

data remove storage macroengine:input _gamerule_norm
