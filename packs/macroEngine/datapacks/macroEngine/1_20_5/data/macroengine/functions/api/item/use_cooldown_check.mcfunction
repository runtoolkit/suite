# macroengine:api/item/use_cooldown_check
#
# Reads minecraft:custom_data.macroengine.cooldown_until from the target's
# MAIN HAND item and reports whether it has expired.
#
# LIMITATION: only the main-hand slot is supported here. "weapon.mainhand" is
# a slot argument valid for /item, /give, and "execute if items" — it is NOT
# a valid /data get NBT path. Reading a specific item's NBT by path requires
# the SelectedItem tag (main hand only) or Inventory[{Slot:N}] for other
# slots. Extending this to arbitrary slots needs a slot->index lookup table
# and is out of scope for this pass.
#
# Call:
# function macroengine:api/item/use_cooldown_check {player:"Steve"}
#
# Output:
# macroengine:output found -> 1b if player found
# macroengine:output ready -> 1b if cooldown has expired (or was never set)
# macroengine:output remaining -> ticks remaining (0 if ready)

data modify storage macroengine:output found set value 0b
data modify storage macroengine:output ready set value 0b
data modify storage macroengine:output remaining set value 0

$execute unless entity @a[name=$(player),limit=1] run return 0
data modify storage macroengine:output found set value 1b

# Reset to 0 first: if the item has no cooldown_until path yet, the "data
# get" below fails and would otherwise leave a stale score from a prior call.
scoreboard players set #macroengine_item_expiry macroengine.tmp 0
execute store result score #macroengine_item_now macroengine.tmp run time query gametime
$execute as @a[name=$(player),limit=1] store result score #macroengine_item_expiry macroengine.tmp run data get entity @s SelectedItem.components."minecraft:custom_data".macroengine.cooldown_until

execute if score #macroengine_item_now macroengine.tmp >= #macroengine_item_expiry macroengine.tmp run data modify storage macroengine:output ready set value 1b
execute unless score #macroengine_item_now macroengine.tmp >= #macroengine_item_expiry macroengine.tmp run scoreboard players operation #macroengine_item_remaining macroengine.tmp = #macroengine_item_expiry macroengine.tmp
execute unless score #macroengine_item_now macroengine.tmp >= #macroengine_item_expiry macroengine.tmp run scoreboard players operation #macroengine_item_remaining macroengine.tmp -= #macroengine_item_now macroengine.tmp
execute unless score #macroengine_item_now macroengine.tmp >= #macroengine_item_expiry macroengine.tmp store result storage macroengine:output remaining int 1 run scoreboard players get #macroengine_item_remaining macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"item/use_cooldown_check ","color":"aqua"},{"text":"$(player)","color":"white"}]
