# DL Tick — Channel Dispatcher
# Increments the internal tick counter then iterates all channels.

scoreboard players add #tick_ctr macroengine.tick 1
data modify storage macroengine:tick_work i set value 0
function macroengine:core/tick/dispatch/step with storage macroengine:tick_work