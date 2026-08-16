# Replace (FindLength > 1)
execute if score #StringLib.FindLength StringLib matches 2.. run return run function macroengine_string:zprivate/replace/check_word_rest

# Replace (FindLength = 1)
data modify storage macroengine_string:temp data.CheckString.String set from storage macroengine_string:temp data.String
data modify storage macroengine_string:input concat append from storage macroengine_string:temp data.StringBefore[]
data modify storage macroengine_string:input concat append from storage macroengine_string:input replace.Replace
data modify storage macroengine_string:temp data.StringBefore set value []
return run scoreboard players add #StringLib.ReturnValue StringLib 1
