# Convert current character to uppercase (& handle a character having 2 possible outputs)
data remove storage macroengine_string:temp data.List
$data modify storage macroengine_string:temp data.List append from storage macroengine_string:zprivate data.CharMap.Full[{l:"$(Char)"}].u
data modify storage macroengine_string:temp data.CharList append from storage macroengine_string:temp data.List[0]
execute unless data storage macroengine_string:temp data.List run data modify storage macroengine_string:temp data.CharList append from storage macroengine_string:temp data.Char

# Next loop
execute if score #StringLib.CharsLeft StringLib matches 1 run return 0
scoreboard players remove #StringLib.CharsLeft StringLib 1
data modify storage macroengine_string:temp data.Input set string storage macroengine_string:temp data.Input 1
data modify storage macroengine_string:temp data.Char set string storage macroengine_string:temp data.Input 0 1
function macroengine_string:zprivate/to_uppercase/main_full with storage macroengine_string:temp data
