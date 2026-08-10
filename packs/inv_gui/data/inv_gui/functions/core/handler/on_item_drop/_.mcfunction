#> inv_gui:core/handler/on_item_drop/_
#
# Called on item drop
#
# @within function inv_gui:core/emitter/check_item_drop/found_dropped_item/player

# Fire event
data modify storage inv_gui:temp SelectionType set value "DROP"
function inv_gui:core/handler/on_select/_
