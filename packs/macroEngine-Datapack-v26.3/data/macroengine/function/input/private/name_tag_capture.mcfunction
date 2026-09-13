# ======================================================================================
# macroengine:input/private/name_tag_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a player holding the marked name_tag.
# Requires a non-empty custom_name (anvil rename). Unnamed tags are ignored.
# Item is NOT cleared — hold-session debounce via macroengine.name_tag_captured.
# ======================================================================================

# Already submitted this hold-session
execute if entity @s[tag=macroengine.name_tag_captured] run return 0

# No custom name yet (still default "Name Tag") — wait for anvil rename
execute unless data entity @s SelectedItem.components."minecraft:custom_name" run return 0


execute unless data entity @s {SelectedItem:{components:{"minecraft:custom_data":{macroengine:{input:1b,inputItem:"name_tag"}}}}} run return 0


data modify storage macroengine:input name_tag.player set from entity @s UUID
data modify storage macroengine:input name_tag.raw set value ""

# Prefer plain .text field, then whole component, then stringified component
#
# REAL BUG (found while debugging "always returns 0"): both fallback
# lines below used 'unless {name_tag:{raw:""}}' — i.e. "run this only
# if raw is NOT empty" — which is backwards. That runs the fallback
# exactly when it's NOT needed (raw already set) and skips it exactly
# when it IS needed (the .text attempt failed and raw is still ""),
# so a custom_name that doesn't expose a plain .text field never gets
# any fallback and raw stays "" — which then always fails the "still
# empty" check below and returns 0. Compare with the correctly-written
# equivalent chain in input/private/anvil_capture.mcfunction, which uses
# 'if {anvil:{new_name:""}}' (run the fallback only when still empty) —
# that is the condition this file needed too.
data modify storage macroengine:input name_tag.raw set from entity @s SelectedItem.components."minecraft:custom_name"
execute if data storage macroengine:input {name_tag:{raw:""}} run data modify storage macroengine:input name_tag.raw set from entity @s SelectedItem.components."minecraft:custom_name"
execute if data storage macroengine:input {name_tag:{raw:""}} run data modify storage macroengine:input name_tag.raw set string entity @s SelectedItem.components."minecraft:custom_name"

# Still empty after extract — do not fire hook
execute if data storage macroengine:input {name_tag:{raw:""}} run return 0

data modify storage macroengine:input name_tag.executed set value 0b
execute if data storage macroengine:input name_tag{executed:0b} run function #macroengine:input/name_tag

# Keep item; block re-fire until player unselects the marked tag
tag @s add macroengine.name_tag_captured
