# ─────────────────────────────────────────────────────────────────
# macroengine:api/wand/register_fn
# Binds a function to a wand (carrot_on_a_stick).
#
# INPUT (storage macroengine:input):
# tag → custom_data tag name
# func → function to run
# ─────────────────────────────────────────────────────────────────
execute unless data storage macroengine:engine wand_binds run data modify storage macroengine:engine wand_binds set value []
function macroengine:core/internal/api/wand/register_fn_do with storage macroengine:input {}
