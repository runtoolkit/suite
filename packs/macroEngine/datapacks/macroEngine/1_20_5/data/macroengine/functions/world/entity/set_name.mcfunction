# ─────────────────────────────────────────────────────────────────
# macroengine:world/entity/set_name
# Sets the display name (CustomName) on every entity matching the
# given tag. The name is read from macroengine:input name — NOT passed
# as a macro argument — to avoid quote/apostrophe injection crashes
# and to support full JSON text components on all versions.
#
# INPUT : $(tag) → entity tag to match
# macroengine:input name → JSON text component (caller sets this
# before calling this function)
#
# CALLER PATTERN:
# # Plain white text (works on all versions):
# data modify storage macroengine:input name set value '"Dragon King"'
#
# # Colored component (works on all versions):
# data modify storage macroengine:input name set value '{"text":"Dragon King","color":"red"}'
#
# function macroengine:world/entity/set_name {tag:"myboss"}
#
# NOTE: data modify storage → CustomName works on all supported
# versions without version-specific syntax differences.
# ─────────────────────────────────────────────────────────────────

$execute as @e[tag=$(tag)] run data modify entity @s CustomName set from storage macroengine:input name
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"entity/set_name ","color":"aqua"},{"text":"[$(tag)]","color":"gray"},{"text":" ← macroengine:input name","color":"#555555"}]
