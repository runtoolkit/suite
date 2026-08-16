# DL Tick — Dispatch Step [MACRO]
# Recursive iterator over tick.channels[].
# Terminates automatically when index exceeds array length.
# Input: $(i) — current channel array index

# Termination: channel[i] absent → stop
$execute unless data storage macroengine:engine tick.channels[$(i)] run return 0

# Process this channel
$function macroengine:core/tick/dispatch/channel {i:$(i)}

# Advance: $(i)+1 → write back → recurse
$scoreboard players set #ch_next macroengine.tick $(i)
scoreboard players add #ch_next macroengine.tick 1
execute store result storage macroengine:tick_work i int 1 run scoreboard players get #ch_next macroengine.tick
function macroengine:core/tick/dispatch/step with storage macroengine:tick_work