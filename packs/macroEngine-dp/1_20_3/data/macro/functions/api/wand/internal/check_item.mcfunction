# macro:api/wand/internal/check_item [LEGACY]
# $(tag) → custom_data tag name
# 1.20.3 uses NBT matching on SelectedItem instead of execute if items.

$execute if entity @s[nbt={SelectedItem:{tag:{wand:"$(tag)"}}}] run function macro:api/wand/internal/fire with storage macro:engine _wand_current
