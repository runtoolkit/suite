# macroengine:systems/hook/on_open_chest
# Binds a function or command to the "open_chest" event.
#
# INPUT (storage macroengine:input):
#   func → function to run when a player opens a chest
#   cmd  → command to run when a player opens a chest (used if func is absent)
#
# USAGE:
#   data modify storage macroengine:input func set value "mypack:on_open_chest"
#   function macroengine:systems/hook/on_open_chest
#   -- or --
#   data modify storage macroengine:input cmd set value "say A chest was opened"
#   function macroengine:systems/hook/on_open_chest
data modify storage macroengine:input event set value "open_chest"
function macroengine:systems/hook/bind
