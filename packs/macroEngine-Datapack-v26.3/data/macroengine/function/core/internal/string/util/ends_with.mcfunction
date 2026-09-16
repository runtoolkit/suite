##########################################################################################################
##                                              HOW TO USE                                              ##
##########################################################################################################
## 1. Set the following data in the 'macroengine:core/internal/string/input ends_with' data storage:    ##
##    - String: Original string                                                                         ##
##    - Suffix: String you want to check for at the end                                                 ##
## 2. Run this function                                                                                 ##
##                                                                                                      ##
## Output: Boolean for whether String ends with Suffix                                                  ##
##         Example:                                                                                     ##
##                 - String: "Hello World!"                                                             ##
##                 - Suffix: "World!"                                                                   ##
##                 => Output: 1b                                                                        ##
##                                                                                                      ##
##                 - String: "Hello World!"                                                             ##
##                 - Suffix: "Hello"                                                                    ##
##                 => Output: 0b                                                                        ##
##                                                                                                      ##
## Return value: 1 if String ends with Suffix, 0 if it doesn't                                          ##
##                                                                                                      ##
## The output is found in the 'macroengine:core/internal/string/output ends_with' data storage          ##
##########################################################################################################

# Setup (save/restore 'find' storage so this doesn't clobber a caller's in-progress find, same pattern as split.mcfunction)
data modify storage macroengine:core/internal/string/temp data2.PrevInput set from storage macroengine:core/internal/string/input find
data modify storage macroengine:core/internal/string/temp data2.PrevOutput set from storage macroengine:core/internal/string/output find

execute store result score #StringLib.FindLength StringLib run data get storage macroengine:core/internal/string/input ends_with.Suffix
execute store result score #StringLib.CharsTotal StringLib run data get storage macroengine:core/internal/string/input ends_with.String
scoreboard players operation #StringLib.CharsTotal StringLib -= #StringLib.FindLength StringLib

# An empty Suffix always matches; a Suffix longer than String never matches
execute if score #StringLib.FindLength StringLib matches 0 run data modify storage macroengine:core/internal/string/output ends_with set value 1b
execute if score #StringLib.CharsTotal StringLib matches ..-1 run data modify storage macroengine:core/internal/string/output ends_with set value 0b

execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. run data modify storage macroengine:core/internal/string/input find.String set from storage macroengine:core/internal/string/input ends_with.String
execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. run data modify storage macroengine:core/internal/string/input find.Find set from storage macroengine:core/internal/string/input ends_with.Suffix
execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. run data remove storage macroengine:core/internal/string/input find.n
execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. run data modify storage macroengine:core/internal/string/input find.n set value -1
execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. run function macroengine:core/internal/string/util/find

execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. store result score #StringLib.Index StringLib run data get storage macroengine:core/internal/string/output find[0]
execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. if score #StringLib.Index StringLib = #StringLib.CharsTotal StringLib run data modify storage macroengine:core/internal/string/output ends_with set value 1b
execute if score #StringLib.FindLength StringLib matches 1.. if score #StringLib.CharsTotal StringLib matches 0.. unless score #StringLib.Index StringLib = #StringLib.CharsTotal StringLib run data modify storage macroengine:core/internal/string/output ends_with set value 0b

# Reset
data modify storage macroengine:core/internal/string/input find set from storage macroengine:core/internal/string/temp data2.PrevInput
data modify storage macroengine:core/internal/string/output find set from storage macroengine:core/internal/string/temp data2.PrevOutput
execute unless data storage macroengine:core/internal/string/temp data2.PrevInput run data remove storage macroengine:core/internal/string/input find
execute unless data storage macroengine:core/internal/string/temp data2.PrevOutput run data remove storage macroengine:core/internal/string/output find
data remove storage macroengine:core/internal/string/temp data2

# Return Values
execute if data storage macroengine:core/internal/string/output {ends_with:1b} run return 1
return 0
