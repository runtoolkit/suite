# macroengine:systems/string/repeat
# Repeats a single character (char) exactly `count` times (1–16).
# Params: char (single character), count (integer 1–16)
# Output: macroengine:output result = repeated string
# Note: count is clamped to 1–16. Larger repeats should be assembled by the caller.
#
# Implementation: static dispatch to internal/repeat_N which sets the literal string.
# Each internal file uses a single $data modify line with N $(char) expansions.

data modify storage macroengine:output result set value ""

$scoreboard players set $sr_n macroengine.tmp $(count)
execute if score $sr_n macroengine.tmp matches ..0 run scoreboard players set $sr_n macroengine.tmp 1
execute if score $sr_n macroengine.tmp matches 17.. run scoreboard players set $sr_n macroengine.tmp 16

execute if score $sr_n macroengine.tmp matches 1 run function macroengine:core/internal/systems/string/repeat_1 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 2 run function macroengine:core/internal/systems/string/repeat_2 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 3 run function macroengine:core/internal/systems/string/repeat_3 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 4 run function macroengine:core/internal/systems/string/repeat_4 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 5 run function macroengine:core/internal/systems/string/repeat_5 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 6 run function macroengine:core/internal/systems/string/repeat_6 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 7 run function macroengine:core/internal/systems/string/repeat_7 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 8 run function macroengine:core/internal/systems/string/repeat_8 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 9 run function macroengine:core/internal/systems/string/repeat_9 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 10 run function macroengine:core/internal/systems/string/repeat_10 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 11 run function macroengine:core/internal/systems/string/repeat_11 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 12 run function macroengine:core/internal/systems/string/repeat_12 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 13 run function macroengine:core/internal/systems/string/repeat_13 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 14 run function macroengine:core/internal/systems/string/repeat_14 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 15 run function macroengine:core/internal/systems/string/repeat_15 with storage macroengine:input {}
execute if score $sr_n macroengine.tmp matches 16 run function macroengine:core/internal/systems/string/repeat_16 with storage macroengine:input {}

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/repeat ","color":"aqua"},{"text":"'$(char)'","color":"yellow"},{"text":" × $(count) → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"white"}]
