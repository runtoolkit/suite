data remove storage macroengine_string:temp data.StringList[-1]
data modify storage macroengine_string:temp data.S2 set from storage macroengine_string:temp data.StringList[-1]
data remove storage macroengine_string:temp data.StringList[-1]
data modify storage macroengine_string:temp data.S3 set from storage macroengine_string:temp data.StringList[-1]
function macroengine_string:zprivate/concat/s/2c with storage macroengine_string:temp data
