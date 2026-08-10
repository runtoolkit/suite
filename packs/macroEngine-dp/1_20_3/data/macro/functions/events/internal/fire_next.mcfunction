data modify storage macro:engine _dispatch.func set from storage macro:engine _event_tmp[0].func
function #macro:internal/dispatch
data remove storage macro:engine _event_tmp[0]
execute if data storage macro:engine _event_tmp[0] run function macro:events/internal/fire_next
