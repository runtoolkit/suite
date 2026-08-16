# DL Tick — Rate/Offset Check [MACRO]
# Fires when (#tick_ctr - offset) % rate == 0.
# Input: $(rate), $(offset), $(fn), $(condition)
#
# rate:1 = every tick | rate:20 = every second | rate:200 = every 10s
# offset: phase shift, spreads channels so they don't all run on the same tick

$scoreboard players set #rate macroengine.tick $(rate)
$scoreboard players set #offset macroengine.tick $(offset)

# Compute modular position
scoreboard players operation #check macroengine.tick = #tick_ctr macroengine.tick
scoreboard players operation #check macroengine.tick -= #offset macroengine.tick
scoreboard players operation #check macroengine.tick %= #rate macroengine.tick

# Fix negative remainder (possible when tick_ctr < offset at world start)
execute if score #check macroengine.tick matches ..-1 run scoreboard players operation #check macroengine.tick += #rate macroengine.tick

# Not this tick → skip
execute unless score #check macroengine.tick matches 0 run return 0

# Passed → execute channel function
execute if data storage macroengine:tick_work channel{condition:""} run function macroengine:core/tick/dispatch/exec with storage macroengine:tick_work channel
execute unless data storage macroengine:tick_work channel{condition:""} run function macroengine:core/tick/dispatch/exec2 with storage macroengine:tick_work channel