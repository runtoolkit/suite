# macroengine:core/tick/channel/disable — Disable a tick channel by ID
# Usage: function macroengine:core/tick/channel/disable {id:"channel_id"}
$data modify storage macroengine:engine tick.channels[{id:"$(id)"}] merge value {enabled:0b}