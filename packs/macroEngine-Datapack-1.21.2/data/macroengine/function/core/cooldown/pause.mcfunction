# macroengine:core/cooldown/pause
# Pauses an active cooldown, saving the remaining ticks.
# Params: player, key
# Output: macroengine:output result (remaining ticks saved), 0b if not active

data modify storage macroengine:output result set value 0b

$execute unless data storage macroengine:engine cooldowns.$(player).$(key) run return 0

# Calculate remaining ticks
$execute store result score $cdp_exp macroengine.tmp run data get storage macroengine:engine cooldowns.$(player).$(key)
execute store result score $cdp_now macroengine.tmp run scoreboard players get $epoch macroengine.time
scoreboard players operation $cdp_exp macroengine.tmp -= $cdp_now macroengine.tmp

# Only pause if actually still active
execute unless score $cdp_exp macroengine.tmp matches 1.. run return 0

# Save remaining ticks to paused storage and clear the live cooldown
$execute store result storage macroengine:engine paused_cooldowns.$(player).$(key) int 1 run scoreboard players get $cdp_exp macroengine.tmp
$data remove storage macroengine:engine cooldowns.$(player).$(key)
execute store result storage macroengine:output result int 1 run scoreboard players get $cdp_exp macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/pause ","color":"aqua"},{"text":"⏸ ","color":"yellow"},{"text":"$(player)","color":"white"},{"text":":","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"},{"text":"t remaining","color":"#555555"}]
