# macro:core/tick/channel/disable — Disable a tick channel by ID
# Usage: function macro:core/tick/channel/disable {id:"channel_id"}
$data modify storage macro:engine tick.channels[{id:"$(id)"}] merge value {enabled:0b}