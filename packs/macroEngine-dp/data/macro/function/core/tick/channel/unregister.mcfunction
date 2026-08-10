# macro:core/tick/channel/unregister — Remove a tick channel by ID
# Usage: function macro:core/tick/channel/unregister {id:"channel_id"}
$data remove storage macro:engine tick.channels[{id:"$(id)"}]