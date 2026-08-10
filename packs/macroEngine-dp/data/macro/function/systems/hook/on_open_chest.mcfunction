# macro:systems/hook/on_open_chest
# Binds a function or command to the "open_chest" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player opens a chest
#   cmd  → command to run when a player opens a chest (used if func is absent)
#
# USAGE:
#   data modify storage macro:input func set value "mypack:on_open_chest"
#   function macro:systems/hook/on_open_chest
#   -- or --
#   data modify storage macro:input cmd set value "say A chest was opened"
#   function macro:systems/hook/on_open_chest
data modify storage macro:input event set value "open_chest"
function macro:systems/hook/bind
