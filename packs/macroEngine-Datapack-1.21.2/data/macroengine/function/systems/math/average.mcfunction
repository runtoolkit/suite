# ─────────────────────────────────────────────────────────────────
# macroengine:systems/math/average
# Computes the integer average of up to 8 values.
#  Input : $(v0)..(v7)  → integer values
#          $(count)     → how many values (1-8)
# Output: macroengine:output result → floor(sum / count)
#
# Example:
# data modify storage macroengine:input v0 set value 10
# data modify storage macroengine:input v1 set value 20
# data modify storage macroengine:input v2 set value 30
# data modify storage macroengine:input count set value 3
# function macroengine:systems/math/average with storage macroengine:input {}
# # macroengine:output result = 20
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $avg_c macroengine.tmp $(count)

execute if score $avg_c macroengine.tmp matches ..0 run data modify storage macroengine:output result set value 0
execute if score $avg_c macroengine.tmp matches ..0 run return 0

$scoreboard players set $avg_s macroengine.tmp $(v0)
$execute if score $avg_c macroengine.tmp matches 2.. run scoreboard players add $avg_s macroengine.tmp $(v1)
$execute if score $avg_c macroengine.tmp matches 3.. run scoreboard players add $avg_s macroengine.tmp $(v2)
$execute if score $avg_c macroengine.tmp matches 4.. run scoreboard players add $avg_s macroengine.tmp $(v3)
$execute if score $avg_c macroengine.tmp matches 5.. run scoreboard players add $avg_s macroengine.tmp $(v4)
$execute if score $avg_c macroengine.tmp matches 6.. run scoreboard players add $avg_s macroengine.tmp $(v5)
$execute if score $avg_c macroengine.tmp matches 7.. run scoreboard players add $avg_s macroengine.tmp $(v6)
$execute if score $avg_c macroengine.tmp matches 8.. run scoreboard players add $avg_s macroengine.tmp $(v7)

scoreboard players operation $avg_s macroengine.tmp /= $avg_c macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $avg_s macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/average ","color":"aqua"},{"text":"count=$(count) ","color":"gray"},{"text":"→ ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
