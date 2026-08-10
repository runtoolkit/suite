#> inv_gui:core/handler/on_item_click/_
#
# Called on item click
#
# @within function inv_gui:core/emitter/check_item_click/_

# Fire event
data modify storage inv_gui:temp SelectionType set value "CLICK"
function inv_gui:core/handler/on_select/_
