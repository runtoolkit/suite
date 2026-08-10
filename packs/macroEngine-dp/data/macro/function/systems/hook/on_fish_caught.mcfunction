# macro:systems/hook/on_fish_caught
# Binds a function or command to the "fish_caught" event.
#
# INPUT (storage macro:input):
#   func → function to run when a player catches a fish
#   cmd  → command to run when a player catches a fish (used if func is absent)
#
# USAGE:
#   data modify storage macro:input func set value "mypack:on_fish"
#   function macro:systems/hook/on_fish_caught
#   -- or --
#   data modify storage macro:input cmd set value "give @s salmon 1"
#   function macro:systems/hook/on_fish_caught
data modify storage macro:input event set value "fish_caught"
function macro:systems/hook/bind
