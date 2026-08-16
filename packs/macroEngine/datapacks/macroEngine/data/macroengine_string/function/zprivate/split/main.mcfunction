# Append the segment from Min to Max (skip empty unless KeepEmpty is 1b)
$data modify storage macroengine_string:temp data.Segment set string storage macroengine_string:input split.String $(Min) $(Max)
execute store result score #StringLib.SegmentLength StringLib run data get storage macroengine_string:temp data.Segment
execute unless score #StringLib.SegmentLength StringLib matches 0 run data modify storage macroengine_string:output split append from storage macroengine_string:temp data.Segment
execute if score #StringLib.SegmentLength StringLib matches 0 if score #StringLib.KeepEmpty StringLib matches 1 run data modify storage macroengine_string:output split append value ""

# This found instance is now consumed; stop once none are left
data remove storage macroengine_string:output find[0]
execute unless data storage macroengine_string:output find[0] run return 0

# Move Min to just after the separator we just split on, then jump Max to the next found index
scoreboard players operation #StringLib.NextMin StringLib = #StringLib.Max StringLib
scoreboard players operation #StringLib.NextMin StringLib += #StringLib.SeparatorLength StringLib
execute store result storage macroengine_string:temp data.Min int 1 run scoreboard players get #StringLib.NextMin StringLib
execute store result storage macroengine_string:temp data.Max int 1 store result score #StringLib.Max StringLib run data get storage macroengine_string:output find[0]

function macroengine_string:zprivate/split/main with storage macroengine_string:temp data
