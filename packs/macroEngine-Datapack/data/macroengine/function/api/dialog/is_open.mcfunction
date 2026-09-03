# ─────────────────────────────────────────────────────────────────
# macroengine:api/dialog/is_open
# Checks whether the executing player currently has a dialog open.
# Output: macroengine:output result → 1b (open) or 0b (closed / not set)
#
# Example:
# execute as @a run function macroengine:api/dialog/is_open
# # Then read macroengine:output result per player context
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output result set value 0b
execute if entity @s[tag=macroengine.dialog_opened] unless entity @s[tag=macroengine.dialog_closed] run data modify storage macroengine:output result set value 1b

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"dialog/is_open ","color":"aqua"},{"text":"→ ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
