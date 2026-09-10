##########################################################################################################
##                                              HOW TO USE                                              ##
##########################################################################################################
## 1. Set the following data in the 'macroengine:core/internal/string/input insert' data storage:                              ##
##    - String: Original string                                                                         ##
##    - Insertion: String you want to insert                                                            ##
##    - Index: Position for the Insertion                                                               ##
## 2. Run this function with the 'macroengine:core/internal/string/input insert' data storage                                  ##
##                                                                                                      ##
## Output: A single combined string                                                                     ##
##         Example:                                                                                     ##
##                 - String: "Hello!"                                                                   ##
##                 - Insertion: " World"                                                                ##
##                 - Index: 5                                                                           ##
##                 => Output: "Hello World!"                                                            ##
##                                                                                                      ##
## The output is found in the 'macroengine:core/internal/string/output insert' data storage                                    ##
##########################################################################################################

# Insert
$data modify storage macroengine:core/internal/string/temp data.S1 set string storage macroengine:core/internal/string/input insert.String 0 $(Index)
$data modify storage macroengine:core/internal/string/temp data.S2 set string storage macroengine:core/internal/string/input insert.String $(Index)
data modify storage macroengine:core/internal/string/temp data.I set from storage macroengine:core/internal/string/input insert.Insertion
function macroengine:core/internal/string/zprivate/insert/main with storage macroengine:core/internal/string/temp data
data remove storage macroengine:core/internal/string/temp data