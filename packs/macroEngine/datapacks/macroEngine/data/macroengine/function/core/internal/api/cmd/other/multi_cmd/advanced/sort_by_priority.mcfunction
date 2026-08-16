# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/advanced/internal/sort_by_priority
# Sorts _mcmd_queue by priority field (ascending).
# Items with no priority field default to 0 (middle bucket).
# Buckets: negative | zero/unset | positive
# Uses sort_scan_loop (classify) + sort_append_loop (merge).
# ─────────────────────────────────────────────────────────────────

# Move queue to sort_buf; initialize buckets
data modify storage macroengine:engine _sort_buf set from storage macroengine:engine _mcmd_queue
data modify storage macroengine:engine _sort_neg set value []
data modify storage macroengine:engine _sort_zero set value []
data modify storage macroengine:engine _sort_pos set value []

# Classify each item into the correct bucket
function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/sort_scan_loop

# Rebuild queue: neg → zero → pos
data modify storage macroengine:engine _mcmd_queue set value []

data modify storage macroengine:engine _sort_tmp set from storage macroengine:engine _sort_neg
function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop

data modify storage macroengine:engine _sort_tmp set from storage macroengine:engine _sort_zero
function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop

data modify storage macroengine:engine _sort_tmp set from storage macroengine:engine _sort_pos
function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/sort_append_loop

# Cleanup
data remove storage macroengine:engine _sort_buf
data remove storage macroengine:engine _sort_neg
data remove storage macroengine:engine _sort_zero
data remove storage macroengine:engine _sort_pos
data remove storage macroengine:engine _sort_tmp
data remove storage macroengine:engine _sort_cur

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/sort ","color":"aqua"},{"text":"✔ sorted by priority","color":"green"}]