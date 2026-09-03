# macroengine:systems/rate_limit/internal/evaluate — Sliding window core [MACRO]
# Input: $(key), $(limit), $(window), $(hits) (array, not used directly here)
#
# Algorithm:
# 1. Get current epoch tick
# 2. Compute window start = epoch - window + 1
# 3. Prune hits older than window start → stored as macroengine:engine rate_limit.rules.<key>.hits
# 4. Count remaining hits
# 5. If count < limit → record new hit, return ALLOWED
# 6. Else → return DENIED (do NOT record hit)

# Step 1: capture current epoch + compute window boundary
execute store result score $rl_now macroengine.tmp run scoreboard players get $epoch macroengine.time
$scoreboard players set $rl_win macroengine.tmp $(window)
scoreboard players operation $rl_start macroengine.tmp = $rl_now macroengine.tmp
scoreboard players operation $rl_start macroengine.tmp -= $rl_win macroengine.tmp
scoreboard players add $rl_start macroengine.tmp 1

# Step 2: write boundary into work storage for the pruner macro
execute store result storage macroengine:rl_work prune_before int 1 run scoreboard players get $rl_start macroengine.tmp

# Step 3: prune expired hits (hits[i].t < prune_before)
# We do this by rebuilding the hits list via internal/prune
$data modify storage macroengine:rl_work rule_key set value "$(key)"
function macroengine:core/internal/systems/rate_limit/prune with storage macroengine:rl_work

# Step 4: count surviving hits
$execute store result score $rl_count macroengine.tmp run data get storage macroengine:engine rate_limit.rules.$(key).hits

# Step 5: compare against limit
$scoreboard players set $rl_limit macroengine.tmp $(limit)

# DENIED path — limit reached
execute if score $rl_count macroengine.tmp >= $rl_limit macroengine.tmp run data modify storage macroengine:output result set value 0b
execute if score $rl_count macroengine.tmp >= $rl_limit macroengine.tmp run return 0

# ALLOWED path — append new hit timestamp
execute store result storage macroengine:rl_work new_hit.t int 1 run scoreboard players get $rl_now macroengine.tmp
$data modify storage macroengine:engine rate_limit.rules.$(key).hits append from storage macroengine:rl_work new_hit

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"rate_limit ","color":"aqua"},{"text":"ALLOW ","color":"#55FF55"},{"text":"$(key)","color":"white"},{"text":" (","color":"#555555"},{"score":{"name":"$rl_count","objective":"macroengine.tmp"},"color":"green"},{"text":"+1/","color":"#555555"},{"text":"$(limit)","color":"green"},{"text":")","color":"#555555"}]
