##########################################################################################################
## HOW TO USE ##
##########################################################################################################
## 1. Run this function with the 'String' macro variable set to what you want to convert to uppercase ##
## Note: This function will cover the entire unicode range of letters, but is also noticeably slower ##
## ##
## Output: Uppercase version of your input ##
## Example: "abc" => "ABC" ##
## ##
## The output is found in the 'macroengine_string:output to_uppercase' data storage ##
##########################################################################################################

# Setup
$data modify storage macroengine_string:temp data.Input set value "$(String)"
execute store result score #StringLib.CharsLeft StringLib run data get storage macroengine_string:temp data.Input
data modify storage macroengine_string:temp data.Char set string storage macroengine_string:temp data.Input 0 1

# Capitalize each character
function macroengine_string:zprivate/to_uppercase/main_full with storage macroengine_string:temp data

# Combine the characters again
data modify storage macroengine_string:temp data2.PrevInput set from storage macroengine_string:input concat
data modify storage macroengine_string:temp data2.PrevOutput set from storage macroengine_string:output concat

data modify storage macroengine_string:input concat set from storage macroengine_string:temp data.CharList
function macroengine_string:util/concat
data modify storage macroengine_string:output to_uppercase set from storage macroengine_string:output concat

data modify storage macroengine_string:input concat set from storage macroengine_string:temp data2.PrevInput
data modify storage macroengine_string:output concat set from storage macroengine_string:temp data2.PrevOutput
execute unless data storage macroengine_string:temp data2.PrevInput run data remove storage macroengine_string:input concat
execute unless data storage macroengine_string:temp data2.PrevOutput run data remove storage macroengine_string:output concat

# Reset
data remove storage macroengine_string:temp data2
