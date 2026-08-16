# macroengine:systems/hook/on_eat
# Binds a function or command to the "eat" event.
#
# INPUT (storage macroengine:input):
# func → function to run when a player eats
# cmd → command to run when a player eats (used if func is absent)
#
# USAGE:
# data modify storage macroengine:input func set value "mypack:on_eat"
# function macroengine:systems/hook/on_eat
# -- or --
# data modify storage macroengine:input cmd set value "say I ate something"
# function macroengine:systems/hook/on_eat
data modify storage macroengine:input event set value "eat"
function macroengine:systems/hook/bind
