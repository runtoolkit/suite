# Append the remaining part of the string after the last separator instance
$data modify storage macroengine_string:temp data.Segment set string storage macroengine_string:input split.String $(Max)
data modify storage macroengine_string:output split append from storage macroengine_string:temp data.Segment
