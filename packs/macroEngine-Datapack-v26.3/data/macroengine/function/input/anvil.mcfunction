# ======================================================================================
# macroengine:input/anvil
# ======================================================================================
#
# TRIGGERED BY: #macroengine:loop (polled every tick)
#
# PURPOSE:
#   Detect a player who has picked up a marked item
#   (custom_data={macroengine:{input:1b}}, given via give_anvil /
#   give_anvil_custom) into their cursor slot after anvil-renaming it.
#   Capture into macroengine:input anvil.old_name / anvil.new_name /
#   anvil.raw, then clear the carrier item.
#
# WHY player.cursor:
#   The cursor slot (the item currently "held" by the mouse while a
#   container/inventory screen is open) has been a checkable slot name
#   since 1.20.5. It only exists while some inventory-type screen is
#   open for that player — with no screen open there is nothing in the
#   cursor slot, so this naturally only fires during a GUI interaction,
#   which an anvil rename-then-pick-up always is.
#
# UNLIKE name_tag/writable_book (kept on capture), THIS INPUT IS
# CONSUMED: the carrier item is cleared as part of capture, matching the
# behavior described for this input type — capture then clear, no
# hold-session debounce needed since the item no longer exists after.
# ======================================================================================

# Fast exit — skip entirely if no player has the marked item in cursor
execute store success score #macroengine.AnvilHit macroengine.tmp if items entity @a player.cursor *[minecraft:custom_data={macroengine:{input:1b}}]
execute if score #macroengine.AnvilHit macroengine.tmp matches 0 run return 0

execute as @a if items entity @s player.cursor *[minecraft:custom_data={macroengine:{input:1b}}] run function macroengine:input/private/anvil_capture
