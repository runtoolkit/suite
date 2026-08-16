##########################################################################################################
## HOW TO USE ##
##########################################################################################################
## 1. Set the following data in the 'macroengine_string:input insert' data storage: ##
## - String: Original string ##
## - Insertion: String you want to insert ##
## - Index: Position for the Insertion ##
## 2. Run this function with the 'macroengine_string:input insert' data storage ##
## ##
## Output: A single combined string ##
## Example: ##
## - String: "Hello!" ##
## - Insertion: " World" ##
## - Index: 5 ##
## => Output: "Hello World!" ##
## ##
## The output is found in the 'macroengine_string:output insert' data storage ##
##########################################################################################################

# Insert
$data modify storage macroengine_string:temp data.S1 set string storage macroengine_string:input insert.String 0 $(Index)
$data modify storage macroengine_string:temp data.S2 set string storage macroengine_string:input insert.String $(Index)
data modify storage macroengine_string:temp data.I set from storage macroengine_string:input insert.Insertion
function macroengine_string:zprivate/insert/main with storage macroengine_string:temp data
data remove storage macroengine_string:temp data