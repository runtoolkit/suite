# macroengine:api/item/owner_tag
#
# Stamps the target's main-hand item with an owner tag under
# minecraft:custom_data.macroengine.owner — a field Mojang does not provide
# natively. Preserves any other macroengine fields already on the item (reads
# the existing compound first via internal/read_macroengine_compound).
#
# Call:
#   function macroengine:api/item/owner_tag {player:"Steve",slot:"weapon.mainhand",owner:"Steve"}
#
# LIMITATION: only writes/reads the main-hand slot reliably. "slot" is
# passed through to /item modify (a valid slot argument there), but the
# existing-compound READ always comes from SelectedItem — see
# api/item/use_cooldown_check for why arbitrary equipment slots cannot be
# read by /data get path. Passing a non-mainhand slot will still WRITE to
# that slot, but will merge against mainhand's existing data, which is
# almost certainly not what you want. Stick to weapon.mainhand for now.
#
# "/data modify entity <player>" is never used — Mojang blocks direct writes
# to player entity data (fails silently); all mutation goes through the
# item component system via /item modify instead.

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage macroengine:output found set value 1b

$data modify storage macroengine:_item_tmp player set value "$(player)"
function macroengine:core/internal/api/item/read_macroengine_compound with storage macroengine:_item_tmp

$data modify storage macroengine:_item_tmp macroengine.owner set value "$(owner)"
$data modify storage macroengine:_item_tmp slot set value "$(slot)"

function macroengine:core/internal/api/item/owner_tag_apply with storage macroengine:_item_tmp
