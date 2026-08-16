# ─────────────────────────────────────────────────────────────────
# macroengine:systems/flag/copy
# Copies a flag value from one key to another.
# If the source flag is set, the destination is set.
# If the source flag is absent, the destination is removed.
#  Input : $(from) → source flag key
#          $(to)   → destination flag key
# Output: macroengine:output result → 1b if copied (flag was set), 0b if cleared
#
# Example:
# data modify storage macroengine:input from set value "feature_a"
# data modify storage macroengine:input to set value "feature_a_backup"
# function macroengine:systems/flag/copy with storage macroengine:input {}
# ─────────────────────────────────────────────────────────────────

# Default: clear destination
data modify storage macroengine:output result set value 0b

$execute if data storage macroengine:engine flags.$(from) run data modify storage macroengine:engine flags.$(to) set value 1b
$execute if data storage macroengine:engine flags.$(from) run data modify storage macroengine:output result set value 1b
$execute unless data storage macroengine:engine flags.$(from) run data remove storage macroengine:engine flags.$(to)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"flag/copy ","color":"aqua"},{"text":"$(from) → $(to) ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
