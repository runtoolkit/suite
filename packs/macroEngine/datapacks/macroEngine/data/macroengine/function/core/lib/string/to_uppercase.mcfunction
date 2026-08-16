# macroengine:core/lib/string/to_uppercase
# Fast variant — covers a-z only (faster)
# Input:  macroengine:input string — string to convert
# Output: macroengine:output string.result — uppercase string
# Dep:    StringLib (CMDred)
data modify storage macroengine:engine _str_bridge.String set from storage macroengine:input string
function macroengine:core/internal/core/lib/string/to_upper_fast_dispatch with storage macroengine:engine _str_bridge
data modify storage macroengine:output string.result set from storage macroengine_string:output to_uppercase
data remove storage macroengine_string:output to_uppercase
data remove storage macroengine:engine _str_bridge
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/to_uppercase","color":"aqua"}]
