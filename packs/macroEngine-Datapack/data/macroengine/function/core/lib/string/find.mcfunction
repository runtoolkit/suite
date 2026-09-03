# macroengine:core/lib/string/find
# Input:  macroengine:input string  — haystack string
#         macroengine:input find    — substring to search
#         macroengine:input n       — instance count (0=all, +n=first n, -n=last n)
# Output: macroengine:output string.result — list of start indices, or [-1] if not found
# Dep:    StringLib (CMDred)
data modify storage macroengine:core/internal/string/input find.String set from storage macroengine:input string
data modify storage macroengine:core/internal/string/input find.Find set from storage macroengine:input find
data remove storage macroengine:core/internal/string/input find.n
data modify storage macroengine:core/internal/string/input find.n set from storage macroengine:input n
function macroengine:core/internal/string/util/find
data modify storage macroengine:output string.result set from storage macroengine:core/internal/string/output find
data remove storage macroengine:core/internal/string/input find
data remove storage macroengine:core/internal/string/output find
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/find","color":"aqua"}]
