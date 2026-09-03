# ============================================================================
# WARNING (detected during the port, behavior NOT CHANGED):
# This function calls the following internal helper function(s), which
# were already missing in the original runtoolkit/macroEngine repo: zprivate/split/fail, zprivate/split/last_segment, zprivate/split/main, zprivate/split/reversed/main, zprivate/split/setup, zprivate/split/split_chars/setup
# These files could not be found on disk (the embedded StringLib copy was
# already incomplete / the true upstream StringLib source could not be
# located). As it stands, this function will fail with a
# "function not found" error.
# The port only moved the namespace — it did NOT invent the missing logic.
# To fix this, locate the true StringLib source (CMDred) and add the
# missing zprivate/* helper functions.
# ============================================================================


##################################################################################
##                                  HOW TO USE                                  ##
##################################################################################
## 1. Set the following data in the 'macroengine:core/internal/string/input split' data storage:       ##
##    - String: Original string                                                 ##
##    - Separator: String that splits the original into multiple                ##
##        - Default: " "                                                        ##
##        - "": Split each character                                            ##
##    - n: Up until which instance of the separator it should split             ##
##        - Unset or 0: All                                                     ##
##        - Positive: First n                                                   ##
##        - Negative: Last -n                                                   ##
##    - KeepEmpty: Boolean for whether to keep empty Strings in the output list ##
##        - Unset or 0b: Remove                                                 ##
##        - 1b: Keep                                                            ##
##                                                                              ##
## 2. Run this function                                                         ##
##                                                                              ##
## Output: List of Strings, separated by the Separator                          ##
##         Example:                                                             ##
##                 - String: "Hello World!"                                     ##
##                 - Separator: " "                                             ##
##                 - n: 1                                                       ##
##                 - KeepEmpty: Unset                                           ##
##                 => Output: ["Hello", "World!"]                               ##
##                                                                              ##
##                 - String: "Test! HelloTestWorld!"                            ##
##                 - Separator: "Test"                                          ##
##                 - n: -1                                                      ##
##                 - KeepEmpty: Unset                                           ##
##                 => Output: ["Test! Hello", "World!"]                         ##
##                                                                              ##
##                 - String: " Hello    World! "                                ##
##                 - Separator: " "                                             ##
##                 - n: Unset                                                   ##
##                 - KeepEmpty: 1b                                              ##
##                 => Output: ["", "Hello", "", "", "", "World!", ""]           ##
##                                                                              ##
##                                                                              ##
## Return value: Number of elements in the output list, or fail                 ##
##                                                                              ##
## The output is found in the 'macroengine:core/internal/string/output split' data storage             ##
##################################################################################
# Potential optimization: Detect if the current instance of the seperator came DIRECTLY after the previous one. If yes, and if KeepEmpty is 0b, ignore it and don't run the macro
# => It's probably best to set up a recursive loop that continues the loop from main, but skips everything for as long as the separators are after each other. So it checks if the *next* one is directly after the current one
# ALSO OPTIMIZE THE "SPLIT EVERY CHARACTER". CAN BE HEAVILY OPTIMIZED TO PREVENT LOOPING

# Setup
data modify storage macroengine:core/internal/string/output split set value []
execute unless data storage macroengine:core/internal/string/input split.Separator run data modify storage macroengine:core/internal/string/temp data.Separator set value " "
data modify storage macroengine:core/internal/string/temp data.Separator set from storage macroengine:core/internal/string/input split.Separator

    # Reset temporary storage & return fail if input string is empty
execute store result score #StringLib.SeparatorLength StringLib run data get storage macroengine:core/internal/string/temp data.Separator
execute store result score #StringLib.CharsTotal StringLib run data get storage macroengine:core/internal/string/input split.String
execute if score #StringLib.CharsTotal StringLib matches 0 run data modify storage macroengine:core/internal/string/output split set value [""]
execute if score #StringLib.CharsTotal StringLib matches 0 run data remove storage macroengine:core/internal/string/temp data
execute if score #StringLib.CharsTotal StringLib matches 0 run return fail

# If separator is empty string, split each character
execute if score #StringLib.SeparatorLength StringLib matches 0 run return run function macroengine:core/internal/string/zprivate/split/split_chars/setup

# Find all instances of the separator
data modify storage macroengine:core/internal/string/temp data2.PrevInput set from storage macroengine:core/internal/string/input find
data modify storage macroengine:core/internal/string/temp data2.PrevOutput set from storage macroengine:core/internal/string/output find

data modify storage macroengine:core/internal/string/input find.String set from storage macroengine:core/internal/string/input split.String
data modify storage macroengine:core/internal/string/input find.Find set from storage macroengine:core/internal/string/temp data.Separator
data remove storage macroengine:core/internal/string/input find.n
data modify storage macroengine:core/internal/string/input find.n set from storage macroengine:core/internal/string/input split.n
function macroengine:core/internal/string/util/find

# Setup
execute store result score #StringLib.KeepEmpty StringLib run data get storage macroengine:core/internal/string/input split.KeepEmpty

    # Reset temporary storage & return fail if no separator was found
execute if data storage macroengine:core/internal/string/output {find:[-1]} run return run function macroengine:core/internal/string/zprivate/split/fail

# Split
execute store result score #StringLib.FindAmount StringLib run data get storage macroengine:core/internal/string/input split.n

    # Split the part in front of every instance of the separator (Do the first iteration here)
execute store result score #StringLib.SplitsLeft StringLib if data storage macroengine:core/internal/string/output find[]

data modify storage macroengine:core/internal/string/temp data.Min set value 0
execute if score #StringLib.FindLength StringLib matches 0.. store result storage macroengine:core/internal/string/temp data.Max int 1 store result score #StringLib.Max StringLib run data get storage macroengine:core/internal/string/output find[0]
execute if score #StringLib.FindLength StringLib matches 0.. run function macroengine:core/internal/string/zprivate/split/main with storage macroengine:core/internal/string/temp data
execute if score #StringLib.FindLength StringLib matches ..-1 store result storage macroengine:core/internal/string/temp data.Max int 1 store result score #StringLib.Max StringLib run data get storage macroengine:core/internal/string/output find[-1]
execute if score #StringLib.FindLength StringLib matches ..-1 run function macroengine:core/internal/string/zprivate/split/reversed/main with storage macroengine:core/internal/string/temp data

    # Append a "" if KeepEmpty is 1b and there's a trailing separator
execute store result storage macroengine:core/internal/string/temp data.Min int 1 run scoreboard players operation #StringLib.Max StringLib += #StringLib.SeparatorLength StringLib
execute if score #StringLib.KeepEmpty StringLib matches 1 if score #StringLib.Max StringLib = #StringLib.CharsTotal StringLib run data modify storage macroengine:core/internal/string/output split append value ""

    # Append the part after the last separator
execute unless score #StringLib.Max StringLib = #StringLib.CharsTotal StringLib run function macroengine:core/internal/string/zprivate/split/last_segment with storage macroengine:core/internal/string/temp data

function macroengine:core/internal/string/zprivate/split/setup with storage macroengine:core/internal/string/temp data

# Reset
data modify storage macroengine:core/internal/string/input find set from storage macroengine:core/internal/string/temp data2.PrevInput
data modify storage macroengine:core/internal/string/output find set from storage macroengine:core/internal/string/temp data2.PrevOutput
execute unless data storage macroengine:core/internal/string/temp data2.PrevInput run data remove storage macroengine:core/internal/string/input find
execute unless data storage macroengine:core/internal/string/temp data2.PrevOutput run data remove storage macroengine:core/internal/string/output find
data remove storage macroengine:core/internal/string/temp data2
data remove storage macroengine:core/internal/string/temp data

# Return Values
return run execute if data storage macroengine:core/internal/string/output split[]