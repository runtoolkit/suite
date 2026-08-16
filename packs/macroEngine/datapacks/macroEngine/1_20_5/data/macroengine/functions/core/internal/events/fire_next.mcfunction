data modify storage macroengine:engine _dispatch.func set from storage macroengine:engine _event_tmp[0].func
function #macroengine:internal/dispatch
data remove storage macroengine:engine _event_tmp[0]
execute if data storage macroengine:engine _event_tmp[0] run function macroengine:core/internal/events/fire_next
