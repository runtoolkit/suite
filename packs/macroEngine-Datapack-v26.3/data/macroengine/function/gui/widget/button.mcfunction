# macroengine:gui :: widget/button    as player
# storage macroengine:gui_w = {slot, item, id, name, lore}      (same keys as widget/draw; type is set to "button")
#
# Draws a button whose behaviour lives in a definition (see widget/button_probe for the click side):
#   data modify storage macroengine:gui_btn defs."ns:id" set value {cmd:"...", ...}      <- in your #macroengine:gui/register listener
#
# If the definition has a `cond` and it fails right now, the item is swapped for `locked_item`
# (default minecraft:barrier). The click handler re-checks the condition, so the look is cosmetic only.
data modify storage macroengine:gui_w type set value "button"
function macroengine:gui/internal/btn_visual with storage macroengine:gui_w
function macroengine:gui/widget/draw
