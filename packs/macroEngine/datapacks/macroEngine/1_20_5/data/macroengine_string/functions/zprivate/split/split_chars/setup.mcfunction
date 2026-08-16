# Split every character of the String into its own list element
execute store result score #StringLib.CharsLeft StringLib run data get storage macroengine_string:input split.String
data modify storage macroengine_string:temp data.Remaining set from storage macroengine_string:input split.String
function macroengine_string:zprivate/split/split_chars/loop
data remove storage macroengine_string:temp data
return run execute if data storage macroengine_string:output split[]
