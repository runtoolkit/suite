# ======================================================================================
# macroengine:input/give_anvil
# ======================================================================================
#
# Gives a marked paper item ready for anvil-rename input capture.
# Flow: player renames it in an anvil, then places/clicks it into the
# cursor slot (opens their inventory or any container and picks the item
# up) to submit. See macroengine:input/anvil for the capture trigger.
#
# For a custom carrier item instead of paper, use give_anvil_custom
# (macro function) with: function macroengine:input/give_anvil_custom {item:"minecraft:item_id"}
#
# The un-renamed display name is stamped via minecraft:item_name so
# anvil_capture can report both the "before" and "after" name even though
# custom_name does not exist until the player actually renames it.
# ======================================================================================

give @s minecraft:paper[minecraft:custom_data={macroengine:{input:1b}},minecraft:item_name={"text":"Anvil Input"}] 1
