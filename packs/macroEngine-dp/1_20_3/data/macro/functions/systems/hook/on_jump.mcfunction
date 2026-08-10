# macro:systems/hook/on_jump
# Binds a function or command to the "jumped" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player jumps
#   cmd  → command to run when a player jumps (used if func is absent)
#
# USAGE:
#   data modify storage macro:input func set value "mypack:on_jump"
#   function macro:systems/hook/on_jump
#   -- or --
#   data modify storage macro:input cmd set value "say A player jumped"
#   function macro:systems/hook/on_jump
data modify storage macro:input event set value "jumped"
function macro:systems/hook/bind
