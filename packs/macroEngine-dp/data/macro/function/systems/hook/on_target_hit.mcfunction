# macro:systems/hook/on_target_hit
# Binds a function or command to the "target_hit" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player hits a target block
#   cmd  → command to run when a player hits a target block (used if func is absent)
#
# USAGE:
#   data modify storage macro:input func set value "mypack:on_target_hit"
#   function macro:systems/hook/on_target_hit
#   -- or --
#   data modify storage macro:input cmd set value "say Target hit"
#   function macro:systems/hook/on_target_hit
data modify storage macro:input event set value "target_hit"
function macro:systems/hook/bind
