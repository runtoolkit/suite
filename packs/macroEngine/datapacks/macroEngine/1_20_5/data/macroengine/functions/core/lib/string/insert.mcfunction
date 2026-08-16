# macroengine:core/lib/string/insert
# Input: macroengine:input string — original string
# macroengine:input insertion — string to insert
# macroengine:input index — insertion position (integer)
# Output: macroengine:output string.result — resulting string
# Dep: StringLib (CMDred)
data modify storage macroengine_string:input insert.String set from storage macroengine:input string
data modify storage macroengine_string:input insert.Insertion set from storage macroengine:input insertion
data modify storage macroengine:engine _str_bridge.Index set from storage macroengine:input index
function macroengine:core/internal/core/lib/string/insert_dispatch with storage macroengine:engine _str_bridge
data modify storage macroengine:output string.result set from storage macroengine_string:output insert
data remove storage macroengine_string:input insert
data remove storage macroengine_string:output insert
data remove storage macroengine:engine _str_bridge
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/insert","color":"aqua"}]
