# macroengine:core/lib/string/concat
# Input:  macroengine:input list   — list of strings to concatenate
# Output: macroengine:output string.result — combined string
# Dep:    StringLib (CMDred)
data modify storage macroengine_string:input concat set from storage macroengine:input list
function macroengine_string:util/concat
data modify storage macroengine:output string.result set from storage macroengine_string:output concat
data remove storage macroengine_string:input concat
data remove storage macroengine_string:output concat
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/concat","color":"aqua"}]
