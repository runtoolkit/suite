# macro:systems/hook/on_drop
# Binds a function or command to the "drop_item" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player drops an item
#   cmd  → command to run when a player drops an item (used if func is absent)
#
# USAGE:
#   data modify storage macro:input func set value "mypack:on_drop"
#   function macro:systems/hook/on_drop
#   -- or --
#   data modify storage macro:input cmd set value "say An item was dropped"
#   function macro:systems/hook/on_drop
data modify storage macro:input event set value "drop_item"
function macro:systems/hook/bind
