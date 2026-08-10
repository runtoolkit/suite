# [MACRO] Internal exec for flag/toggle_system
$execute if data storage macro:tick_work _ftgl{enabled:1b} run function macro:core/tick/channel/disable {id:"$(id)"}
$execute if data storage macro:tick_work _ftgl{enabled:0b} run function macro:core/tick/channel/enable {id:"$(id)"}
