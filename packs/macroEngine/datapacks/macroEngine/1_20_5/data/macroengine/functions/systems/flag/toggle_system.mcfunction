# macroengine:systems/flag/toggle_system — Toggle a built-in tick channel on/off
# Usage: function macroengine:systems/flag/toggle_system {system:"time"}
# Valid systems: time | queue | player | hud | admin
# Delegates to macroengine:core/tick/channel/enable|disable internally.

$data modify storage macroengine:tick_work _ftgl set from storage macroengine:engine tick.channels[{id:"$(system)_systems"}]
function macroengine:systems/flag/toggle_system/exec with storage macroengine:tick_work _ftgl