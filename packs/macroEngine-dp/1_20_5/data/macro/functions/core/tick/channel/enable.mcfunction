# macro:core/tick/channel/enable — Enable a tick channel by ID
# Usage: function macro:core/tick/channel/enable {id:"channel_id"}
$data modify storage macro:engine tick.channels[{id:"$(id)"}] merge value {enabled:1b}