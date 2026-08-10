# macro:systems/hook/on_eat
# Binds a function or command to the "eat" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player eats
#   cmd  → command to run when a player eats (used if func is absent)
data modify storage macro:input event set value "eat"
function macro:systems/hook/bind
