# macroengine:core/lib/string/to_string
# Input: macroengine:input value — numeric or any SNBT value to stringify
# Output: macroengine:output string.result — string representation
# Note: Prefer 'data modify ... set string storage ...' when possible (cheaper)
# Dep: StringLib (CMDred)
data modify storage macroengine:engine _str_bridge.Input set from storage macroengine:input value
function macroengine:core/internal/core/lib/string/to_string_dispatch with storage macroengine:engine _str_bridge
data modify storage macroengine:output string.result set from storage macroengine_string:output to_string
data remove storage macroengine_string:output to_string
data remove storage macroengine:engine _str_bridge
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_string","color":"aqua"}]
