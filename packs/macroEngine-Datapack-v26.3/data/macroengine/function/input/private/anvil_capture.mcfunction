# ======================================================================================
# macroengine:input/private/anvil_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a player currently holding the marked item in
# their cursor slot. Snapshot-then-clear, same TOCTOU-safe shape as
# cbm_capture: read everything we need out of the cursor item BEFORE
# clearing it, so nothing can change underneath us between the read and
# the clear.
#
# WHY A SCRATCH chest_minecart:
#   The cursor slot (player.cursor) is checkable with `execute if items`
#   but is NOT a readable `data get/modify entity` NBT path on the
#   player itself — it lives outside the normal Inventory list while a
#   container/inventory screen is open. To actually read its components
#   we copy it OUT to a throwaway, invisible chest_minecart's
#   container.0 slot via `item replace ... from entity @s player.cursor`
#   (a real container entity, so its Items[{Slot:0b}] NBT is a normal
#   readable path — same shape already relied on elsewhere in this pack
#   for command_block_minecart capture), read the copy, then kill the
#   scratch entity. The player's actual cursor item is left untouched by
#   this copy step; it is cleared explicitly afterward.
#
# old_name — the carrier's pre-rename display name (minecraft:item_name,
#            stamped by give_anvil / give_anvil_custom). Falls back to
#            the literal string "Anvil Input" if item_name is somehow
#            missing (should not happen via the give functions above).
# new_name — the post-rename name (minecraft:custom_name), i.e. whatever
#            the player typed into the anvil. Empty string if the player
#            picked the item back up without renaming it — callers
#            should treat empty new_name as "no input submitted".
# raw      — alias for new_name. This is the RAW, UNVALIDATED string;
#            run it through macroengine:input/validate/check before
#            using it as a number/bool/tag-safe literal.
# ======================================================================================

data modify storage macroengine:input anvil.player set from entity @s UUID

# --- Copy cursor item into a throwaway container entity, right on top of the player ---
summon minecraft:chest_minecart ~ ~ ~ {Invisible:1b,Tags:["macroengine.anvil_scratch"]}
item replace entity @e[tag=macroengine.anvil_scratch,limit=1,sort=nearest] container.0 from entity @s player.cursor

# --- old name (pre-rename item_name) ---
data modify storage macroengine:input anvil.old_name set value "Anvil Input"
execute as @e[tag=macroengine.anvil_scratch,limit=1,sort=nearest] run data modify storage macroengine:input anvil.old_name set from entity @s Items[{Slot:0b}].components."minecraft:item_name".text
execute as @e[tag=macroengine.anvil_scratch,limit=1,sort=nearest] unless data storage macroengine:input {anvil:{old_name:""}} unless data entity @s Items[{Slot:0b}].components."minecraft:item_name".text run data modify storage macroengine:input anvil.old_name set from entity @s Items[{Slot:0b}].components."minecraft:item_name"

# --- new name (post-rename custom_name), with raw fallback chain ---
data modify storage macroengine:input anvil.new_name set value ""
execute as @e[tag=macroengine.anvil_scratch,limit=1,sort=nearest] run data modify storage macroengine:input anvil.new_name set from entity @s Items[{Slot:0b}].components."minecraft:custom_name".text
execute as @e[tag=macroengine.anvil_scratch,limit=1,sort=nearest] if data storage macroengine:input {anvil:{new_name:""}} run data modify storage macroengine:input anvil.new_name set from entity @s Items[{Slot:0b}].components."minecraft:custom_name"
execute as @e[tag=macroengine.anvil_scratch,limit=1,sort=nearest] if data storage macroengine:input {anvil:{new_name:""}} run data modify storage macroengine:input anvil.new_name set string entity @s Items[{Slot:0b}].components."minecraft:custom_name"

data modify storage macroengine:input anvil.raw set from storage macroengine:input anvil.new_name

# Scratch entity's job is done — remove it before touching the player's actual cursor
kill @e[tag=macroengine.anvil_scratch]

# Mark pending BEFORE firing the hook so a slow/missing handler cannot
# cause a re-fire loop on the same item during the same tick.
tag @s add macroengine.anvil_pending

# Consume the carrier now — this input type is single-use, unlike the
# "kept while held" contract of name_tag/writable_book. Clear the
# cursor slot specifically (not the whole inventory).
item replace entity @s player.cursor with air

data modify storage macroengine:input anvil.executed set value 0b
execute if data storage macroengine:input anvil{executed:0b} run function #macroengine:input/anvil

tag @s remove macroengine.anvil_pending
data remove storage macroengine:input anvil
