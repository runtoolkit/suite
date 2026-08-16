# macroengine:core/tick/channel/set_offset — Change phase offset (0 to rate-1)
# Usage: function macroengine:core/tick/channel/set_offset {id:"channel_id",offset:5}
$data modify storage macroengine:engine tick.channels[{id:"$(id)"}] merge value {offset:$(offset)}