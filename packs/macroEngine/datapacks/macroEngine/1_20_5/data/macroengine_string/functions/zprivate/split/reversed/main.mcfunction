# Append the segment from Min to Max (skip empty unless KeepEmpty is 1b) — inserted at the front to preserve left-to-right order
$data modify storage macroengine_string:temp data.Segment set string storage macroengine_string:input split.String $(Min) $(Max)
execute store result score #StringLib.SegmentLength StringLib run data get storage macroengine_string:temp data.Segment
execute unless score #StringLib.SegmentLength StringLib matches 0 run data modify storage macroengine_string:output split prepend from storage macroengine_string:temp data.Segment
execute if score #StringLib.SegmentLength StringLib matches 0 if score #StringLib.KeepEmpty StringLib matches 1 run data modify storage macroengine_string:output split prepend value ""

# This found instance is now consumed; stop once none are left
data remove storage macroengine_string:output find[-1]
execute unless data storage macroengine_string:output find[-1] run return 0

# Move Max to just before the separator we just split on (i.e. Min of this segment), then jump Min to the previous found index + separator length
data modify storage macroengine_string:temp data.Max set from storage macroengine_string:temp data.Min
execute store result score #StringLib.Max StringLib run data get storage macroengine_string:temp data.Max
execute store result storage macroengine_string:temp data.Min int 1 store result score #StringLib.PrevIndex StringLib run data get storage macroengine_string:output find[-1]
scoreboard players operation #StringLib.PrevIndex StringLib += #StringLib.SeparatorLength StringLib
execute store result storage macroengine_string:temp data.Min int 1 run scoreboard players get #StringLib.PrevIndex StringLib

function macroengine_string:zprivate/split/reversed/main with storage macroengine_string:temp data
