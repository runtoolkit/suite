# ======================================================================================
# macroengine:input/give_anvil_custom  [macro]
# ======================================================================================
#
# Same as give_anvil, but lets the caller choose the carrier item id.
# The carrier MUST be anvil-renameable (i.e. not a block that can't sit
# in an anvil input slot in survival — armor, tools, books, and most
# plain items all work; shulker boxes etc. also work).
#
# CALL: function macroengine:input/give_anvil_custom {item:"minecraft:iron_ingot"}
# ======================================================================================

$give @s $(item)[minecraft:custom_data={macroengine:{input:1b}},minecraft:item_name={"text":"Anvil Input"}] 1
