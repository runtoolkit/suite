# DL Tick — Channel Loader [MACRO]
# Copies channels[i] into work storage, skips if disabled.
# Input: $(i) — channel index

$data modify storage macroengine:tick_work channel set from storage macroengine:engine tick.channels[$(i)]
execute unless data storage macroengine:tick_work channel{enabled:1b} run return 0
function macroengine:core/tick/dispatch/rate_check with storage macroengine:tick_work channel