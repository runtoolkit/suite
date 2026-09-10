# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/advanced/internal/sort_scan_loop
# Recursive: dequeue one item from _sort_buf and classify it.
# ─────────────────────────────────────────────────────────────────

execute unless data storage macroengine:engine _sort_buf[0] run return 0

data modify storage macroengine:engine _sort_cur set from storage macroengine:engine _sort_buf[0]
data remove storage macroengine:engine _sort_buf[0]

# Read priority into scoreboard — returns 0 if field absent (desired default)
execute store result score $sort_pri macroengine.tmp run data get storage macroengine:engine _sort_cur.priority

execute if score $sort_pri macroengine.tmp matches ..-1 run data modify storage macroengine:engine _sort_neg append from storage macroengine:engine _sort_cur
execute if score $sort_pri macroengine.tmp matches 0 run data modify storage macroengine:engine _sort_zero append from storage macroengine:engine _sort_cur
execute if score $sort_pri macroengine.tmp matches 1.. run data modify storage macroengine:engine _sort_pos append from storage macroengine:engine _sort_cur

scoreboard players reset $sort_pri macroengine.tmp

function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/sort_scan_loop
