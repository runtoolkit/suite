# macroengine:core/lib/string/split
# Input:  macroengine:input string      — original string
#         macroengine:input separator   — split delimiter (default " ", ""=each char)
#         macroengine:input n           — max splits (0/unset=all, +n=first n, -n=last n)
#         macroengine:input keep_empty  — 1b to keep empty segments, omit/0b to strip
# Output: macroengine:output string.result — list of string segments
# Dep:    StringLib (CMDred)
data modify storage macroengine:core/internal/string/input split.String set from storage macroengine:input string
data remove storage macroengine:core/internal/string/input split.Separator
data modify storage macroengine:core/internal/string/input split.Separator set from storage macroengine:input separator
data remove storage macroengine:core/internal/string/input split.n
data modify storage macroengine:core/internal/string/input split.n set from storage macroengine:input n
data remove storage macroengine:core/internal/string/input split.KeepEmpty
data modify storage macroengine:core/internal/string/input split.KeepEmpty set from storage macroengine:input keep_empty
function macroengine:core/internal/string/util/split
data modify storage macroengine:output string.result set from storage macroengine:core/internal/string/output split
data remove storage macroengine:core/internal/string/input split
data remove storage macroengine:core/internal/string/output split
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/string/split","color":"aqua"}]
