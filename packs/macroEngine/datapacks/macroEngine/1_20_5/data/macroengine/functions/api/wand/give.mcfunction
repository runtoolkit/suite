# ─────────────────────────────────────────────────────────────────
# macroengine:api/wand/give
# Gives the player a carrot_on_a_stick marked as a wand.
# The item is automatically tagged with custom_data.
#
# INPUT:
# $(player) → target player
# $(tag) → wand tag (written into custom_data)
# $(name) → item name (JSON text component, e.g. "Fire Wand")
#
# EXAMPLE:
# data modify storage macroengine:input player set value "Steve"
# data modify storage macroengine:input tag set value "fire_wand"
# data modify storage macroengine:input name set value "Fire Wand"
# function macroengine:api/wand/give with storage macroengine:input {}
# ─────────────────────────────────────────────────────────────────

$give @a[name=$(player),limit=1] minecraft:carrot_on_a_stick[minecraft:custom_data={wand:"$(tag)"},minecraft:item_name={"text":"$(name)"},minecraft:enchantment_glint_override=true]
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"wand/give ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(tag)","color":"aqua"}]
