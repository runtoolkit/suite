# [MACRO] Internal exec for flag/toggle_system
$execute if data storage macroengine:tick_work _ftgl{enabled:1b} run function macroengine:core/tick/channel/disable {id:"$(id)"}
$execute if data storage macroengine:tick_work _ftgl{enabled:0b} run function macroengine:core/tick/channel/enable {id:"$(id)"}
