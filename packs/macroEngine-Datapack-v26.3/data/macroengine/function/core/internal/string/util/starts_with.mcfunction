##########################################################################################################
##                                              HOW TO USE                                              ##
##########################################################################################################
## 1. Set the following data in the 'macroengine:core/internal/string/input starts_with' data storage:  ##
##    - String: Original string                                                                         ##
##    - Prefix: String you want to check for at the start                                               ##
## 2. Run this function                                                                                 ##
##                                                                                                      ##
## Output: Boolean for whether String starts with Prefix                                                ##
##         Example:                                                                                     ##
##                 - String: "Hello World!"                                                             ##
##                 - Prefix: "Hello"                                                                     ##
##                 => Output: 1b                                                                        ##
##                                                                                                      ##
##                 - String: "Hello World!"                                                             ##
##                 - Prefix: "World"                                                                    ##
##                 => Output: 0b                                                                        ##
##                                                                                                      ##
## Return value: 1 if String starts with Prefix, 0 if it doesn't                                        ##
##                                                                                                      ##
## The output is found in the 'macroengine:core/internal/string/output starts_with' data storage        ##
##########################################################################################################

# Setup (save/restore 'find' storage so this doesn't clobber a caller's in-progress find, same pattern as split.mcfunction)
data modify storage macroengine:core/internal/string/temp data2.PrevInput set from storage macroengine:core/internal/string/input find
data modify storage macroengine:core/internal/string/temp data2.PrevOutput set from storage macroengine:core/internal/string/output find

execute store result score #StringLib.FindLength StringLib run data get storage macroengine:core/internal/string/input starts_with.Prefix

# An empty Prefix always matches
execute if score #StringLib.FindLength StringLib matches 0 run data modify storage macroengine:core/internal/string/output starts_with set value 1b

execute if score #StringLib.FindLength StringLib matches 1.. run data modify storage macroengine:core/internal/string/input find.String set from storage macroengine:core/internal/string/input starts_with.String
execute if score #StringLib.FindLength StringLib matches 1.. run data modify storage macroengine:core/internal/string/input find.Find set from storage macroengine:core/internal/string/input starts_with.Prefix
execute if score #StringLib.FindLength StringLib matches 1.. run data remove storage macroengine:core/internal/string/input find.n
execute if score #StringLib.FindLength StringLib matches 1.. run data modify storage macroengine:core/internal/string/input find.n set value 1
execute if score #StringLib.FindLength StringLib matches 1.. run function macroengine:core/internal/string/util/find

execute if score #StringLib.FindLength StringLib matches 1.. if data storage macroengine:core/internal/string/output {find:[0]} run data modify storage macroengine:core/internal/string/output starts_with set value 1b
execute if score #StringLib.FindLength StringLib matches 1.. unless data storage macroengine:core/internal/string/output {find:[0]} run data modify storage macroengine:core/internal/string/output starts_with set value 0b

# Reset
data modify storage macroengine:core/internal/string/input find set from storage macroengine:core/internal/string/temp data2.PrevInput
data modify storage macroengine:core/internal/string/output find set from storage macroengine:core/internal/string/temp data2.PrevOutput
execute unless data storage macroengine:core/internal/string/temp data2.PrevInput run data remove storage macroengine:core/internal/string/input find
execute unless data storage macroengine:core/internal/string/temp data2.PrevOutput run data remove storage macroengine:core/internal/string/output find
data remove storage macroengine:core/internal/string/temp data2

# Return Values
execute if data storage macroengine:core/internal/string/output {starts_with:1b} run return 1
return 0
