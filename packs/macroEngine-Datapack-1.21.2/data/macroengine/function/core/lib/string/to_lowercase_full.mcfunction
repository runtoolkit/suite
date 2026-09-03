# macroengine:core/lib/string/to_lowercase_full
# Full variant — covers full Unicode uppercase mapping (slower)
# Input:  macroengine:input string — string to convert
# Output: macroengine:output string.result — lowercase string
# Dep:    StringLib (CMDred)
data modify storage macroengine:engine _str_bridge.String set from storage macroengine:input string
function macroengine:core/internal/core/lib/string/to_lower_full_dispatch with storage macroengine:engine _str_bridge
data modify storage macroengine:output string.result set from storage macroengine:core/internal/string/output to_lowercase
data remove storage macroengine:core/internal/string/output to_lowercase
data remove storage macroengine:engine _str_bridge
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_lowercase_full","color":"aqua"}]
