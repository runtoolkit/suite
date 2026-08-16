# No instance of the Separator was found - the whole String is the only element
data modify storage macroengine_string:output split append from storage macroengine_string:input split.String
data remove storage macroengine_string:temp data
return 1
