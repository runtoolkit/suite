# ======================================================================================
# macroengine:input/name_tag
# ======================================================================================
#
# TRIGGERED BY: #macroengine:loop (polled every tick)
#
# PURPOSE:
#   Detect a player holding a name_tag marked with
#   custom_data={macroengine:{input:1b,inputItem:"name_tag"}} that has
#   been anvil-renamed (custom_name present). Capture into
#   macroengine:input name_tag.raw. Item is kept. Empty / unrenamed tags
#   are ignored.
# ======================================================================================

# Release debounce when no longer holding a marked name_tag.
# inputItem:"name_tag" distinguishes this from other input:1b carriers
# (anvil, writable_book) that used to share the same bare flag; the
# id:"minecraft:name_tag" check already prevented most cross-triggering
# here, but inputItem keeps the guard consistent with the other methods.
execute as @a[tag=macroengine.name_tag_captured] unless entity @s[nbt={SelectedItem:{id:"minecraft:name_tag",components:{"minecraft:custom_data":{macroengine:{input:1b,inputItem:"name_tag"}}}}}] run tag @s remove macroengine.name_tag_captured

# Fast exit
execute unless entity @a[nbt={SelectedItem:{id:"minecraft:name_tag",components:{"minecraft:custom_data":{macroengine:{input:1b,inputItem:"name_tag"}}}}}] run return 0

execute as @a[nbt={SelectedItem:{id:"minecraft:name_tag",components:{"minecraft:custom_data":{macroengine:{input:1b,inputItem:"name_tag"}}}}}] run function macroengine:input/private/name_tag_capture
