# macroengine:api/item/combo_marker
#
# Stamps a consecutive-use counter under minecraft:custom_data.macroengine.combo
# on the target's held item — for "combo" mechanics (e.g. bonus effects
# after N consecutive uses without switching items). Mojang tracks no
# per-item use streak; this is purely datapack-side bookkeeping. Preserves
# any other macroengine fields already on the item.
#
# Call:
#   function macroengine:api/item/combo_marker {player:"Steve",slot:"weapon.mainhand",combo:3}
#
# Callers are responsible for incrementing/resetting "combo" between calls
# (e.g. via a player-scoped scoreboard objective) — this function only
# writes the given value onto the item, it does not track state itself.

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage macroengine:output found set value 1b

$data modify storage macroengine:_item_tmp player set value "$(player)"
function macroengine:core/internal/api/item/read_macroengine_compound with storage macroengine:_item_tmp

$data modify storage macroengine:_item_tmp macroengine.combo set value $(combo)
$data modify storage macroengine:_item_tmp slot set value "$(slot)"

function macroengine:core/internal/api/item/combo_marker_apply with storage macroengine:_item_tmp
