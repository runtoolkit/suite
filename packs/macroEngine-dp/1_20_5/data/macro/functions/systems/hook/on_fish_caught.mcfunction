# macro:systems/hook/on_fish_caught
# Binds a function or command to the "fish_caught" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player catches a fish
#   cmd  → command to run (used if func is absent)
data modify storage macro:input event set value "fish_caught"
function macro:systems/hook/bind
