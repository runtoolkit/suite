# Append 'String' once per remaining repetition, then combine everything with 'concat' once the list is complete
data modify storage macroengine:core/internal/string/input concat append from storage macroengine:core/internal/string/temp data.String
scoreboard players remove #StringLib.RepeatAmount StringLib 1
execute if score #StringLib.RepeatAmount StringLib matches 1.. run function macroengine:core/internal/string/zprivate/repeat/main
execute if score #StringLib.RepeatAmount StringLib matches ..0 run function macroengine:core/internal/string/util/concat
