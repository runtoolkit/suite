# Peel off the first character and append it as its own element
data modify storage macroengine_string:temp data.Char set string storage macroengine_string:temp data.Remaining 0 1
data modify storage macroengine_string:output split append from storage macroengine_string:temp data.Char

# Next loop
execute if score #StringLib.CharsLeft StringLib matches 1 run return 0
scoreboard players remove #StringLib.CharsLeft StringLib 1
data modify storage macroengine_string:temp data.Remaining set string storage macroengine_string:temp data.Remaining 1
function macroengine_string:zprivate/split/split_chars/loop
