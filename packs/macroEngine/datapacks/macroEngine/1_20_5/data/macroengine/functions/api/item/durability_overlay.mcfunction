# macroengine:api/item/durability_overlay
#
# Stamps a secondary, datapack-tracked durability counter under
# minecraft:custom_data.macroengine.overlay_durability — independent of
# vanilla's minecraft:damage component. Lets a pack track "custom uses
# remaining" on items that are not damageable, or track a second pool
# (e.g. "charges") alongside real durability. Mojang has no such secondary
# counter. Preserves any other macroengine fields already on the item.
#
# Call:
# function macroengine:api/item/durability_overlay {player:"Steve",slot:"weapon.mainhand",value:50}

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage macroengine:output found set value 1b

$data modify storage macroengine:_item_tmp player set value "$(player)"
function macroengine:core/internal/api/item/read_macroengine_compound with storage macroengine:_item_tmp

$data modify storage macroengine:_item_tmp macroengine.overlay_durability set value $(value)
$data modify storage macroengine:_item_tmp slot set value "$(slot)"

function macroengine:core/internal/api/item/durability_overlay_apply with storage macroengine:_item_tmp
