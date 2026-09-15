##########################################################################################################
##                                              HOW TO USE                                              ##
##########################################################################################################
## 1. Set the following data in the 'macroengine:core/internal/string/input repeat' data storage:       ##
##    - String: String you want to repeat                                                               ##
##    - Count: How many times to repeat it                                                              ##
##        - 0 or negative: Output is ""                                                                 ##
## 2. Run this function                                                                                 ##
##                                                                                                      ##
## Output: 'String' repeated 'Count' times, back to back                                                ##
##         Example:                                                                                     ##
##                 - String: "ab"                                                                       ##
##                 - Count: 3                                                                            ##
##                 => Output: "ababab"                                                                  ##
##                                                                                                      ##
## Return value: Number of repetitions performed (0 for an empty String or a non-positive Count)         ##
##                                                                                                      ##
## The output is found in the 'macroengine:core/internal/string/output repeat' data storage             ##
##########################################################################################################

# Setup
data modify storage macroengine:core/internal/string/output repeat set value ""
execute store result score #StringLib.RepeatAmount StringLib run data get storage macroengine:core/internal/string/input repeat.Count
execute store result score #StringLib.FindLength StringLib run data get storage macroengine:core/internal/string/input repeat.String

# 0 or negative Count, or an empty String: output stays ""
execute if score #StringLib.RepeatAmount StringLib matches ..0 run return 0
execute if score #StringLib.FindLength StringLib matches 0 run return 0

# Exactly 1 repetition: nothing to concatenate
execute if score #StringLib.RepeatAmount StringLib matches 1 run data modify storage macroengine:core/internal/string/output repeat set from storage macroengine:core/internal/string/input repeat.String
execute if score #StringLib.RepeatAmount StringLib matches 1 run return 1

# 2 or more: save/restore 'concat' storage so this doesn't clobber a caller's in-progress concat (same pattern as to_lowercase/to_uppercase)
data modify storage macroengine:core/internal/string/temp data2.PrevInput set from storage macroengine:core/internal/string/input concat
data modify storage macroengine:core/internal/string/temp data2.PrevOutput set from storage macroengine:core/internal/string/output concat

data modify storage macroengine:core/internal/string/temp data.String set from storage macroengine:core/internal/string/input repeat.String
scoreboard players operation #StringLib.RepeatTotal StringLib = #StringLib.RepeatAmount StringLib
data modify storage macroengine:core/internal/string/input concat set value []
function macroengine:core/internal/string/zprivate/repeat/main

data modify storage macroengine:core/internal/string/output repeat set from storage macroengine:core/internal/string/output concat

data modify storage macroengine:core/internal/string/input concat set from storage macroengine:core/internal/string/temp data2.PrevInput
data modify storage macroengine:core/internal/string/output concat set from storage macroengine:core/internal/string/temp data2.PrevOutput
execute unless data storage macroengine:core/internal/string/temp data2.PrevInput run data remove storage macroengine:core/internal/string/input concat
execute unless data storage macroengine:core/internal/string/temp data2.PrevOutput run data remove storage macroengine:core/internal/string/output concat

# Reset
data remove storage macroengine:core/internal/string/temp data
data remove storage macroengine:core/internal/string/temp data2

# Return Values
return run scoreboard players get #StringLib.RepeatTotal StringLib
