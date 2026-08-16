data remove storage macroengine_string:temp data.StringList[-1]
data modify storage macroengine_string:temp data.S2 set from storage macroengine_string:temp data.StringList[-1]
function macroengine_string:zprivate/concat/s/1c with storage macroengine_string:temp data
