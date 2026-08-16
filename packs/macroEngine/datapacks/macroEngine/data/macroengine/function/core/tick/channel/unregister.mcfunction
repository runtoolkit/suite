# macroengine:core/tick/channel/unregister — Remove a tick channel by ID
# Usage: function macroengine:core/tick/channel/unregister {id:"channel_id"}
$data remove storage macroengine:engine tick.channels[{id:"$(id)"}]