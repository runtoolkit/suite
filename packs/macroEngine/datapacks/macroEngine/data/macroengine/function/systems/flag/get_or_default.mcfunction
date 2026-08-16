# ─────────────────────────────────────────────────────────────────
# macroengine:systems/flag/get_or_default
# Returns 1b if the flag is set, otherwise stores the given default.
#  Input : $(key)     → flag key
#          $(default) → value to store if flag is absent (0b or 1b)
#  Output: macroengine:output result → 1b if set, $(default) if absent
#
# Example:
# data modify storage macroengine:input key set value "my_feature"
# data modify storage macroengine:input default set value 0b
# function macroengine:systems/flag/get_or_default with storage macroengine:input {}
# # macroengine:output result = 0b (if flag not set)
# ─────────────────────────────────────────────────────────────────

$data modify storage macroengine:output result set value $(default)
$execute if data storage macroengine:engine flags.$(key) run data modify storage macroengine:output result set value 1b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"flag/get_or_default ","color":"aqua"},{"text":"$(key) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
