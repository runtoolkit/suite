# macroengine:core/lib/string/replace
# Input: macroengine:input string — original string
# macroengine:input find — substring to replace
# macroengine:input replace — replacement string
# macroengine:input n — instance count (0/unset=all, +n=first n, -n=last n)
# Output: macroengine:output string.result — resulting string
# Dep: StringLib (CMDred)
data modify storage macroengine_string:input replace.String set from storage macroengine:input string
data modify storage macroengine_string:input replace.Find set from storage macroengine:input find
data modify storage macroengine_string:input replace.Replace set from storage macroengine:input replace
data remove storage macroengine_string:input replace.n
data modify storage macroengine_string:input replace.n set from storage macroengine:input n
function macroengine_string:util/replace
data modify storage macroengine:output string.result set from storage macroengine_string:output replace
data remove storage macroengine_string:input replace
data remove storage macroengine_string:output replace
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/replace","color":"aqua"}]
