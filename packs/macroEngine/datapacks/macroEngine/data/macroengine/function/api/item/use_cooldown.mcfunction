# macroengine:api/item/use_cooldown
#
# Stamps a per-item custom cooldown expiry tick under
# minecraft:custom_data.macroengine.cooldown_until — independent of vanilla's
# shared "/cooldown" system (which is per-item-type, not per-item-instance).
# Preserves any other macroengine fields already on the item.
#
# Call:
#   function macroengine:api/item/use_cooldown {player:"Steve",slot:"weapon.mainhand",ticks:100}
#
# "ticks" is an offset added to the current world time; stored as an
# absolute expiry tick so checking it later is a single comparison
# (see api/item/use_cooldown_check).

data modify storage macroengine:output found set value 0b

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage macroengine:output found set value 1b

# Compute absolute expiry tick = current gametime + requested offset
execute store result score #macroengine_item_now macroengine.tmp run time query gametime
$scoreboard players add #macroengine_item_now macroengine.tmp $(ticks)
execute store result storage macroengine:_item_tmp expiry int 1 run scoreboard players get #macroengine_item_now macroengine.tmp

$data modify storage macroengine:_item_tmp player set value "$(player)"
function macroengine:core/internal/api/item/read_macroengine_compound with storage macroengine:_item_tmp

data modify storage macroengine:_item_tmp macroengine.cooldown_until set from storage macroengine:_item_tmp expiry
$data modify storage macroengine:_item_tmp slot set value "$(slot)"

function macroengine:core/internal/api/item/use_cooldown_apply with storage macroengine:_item_tmp
