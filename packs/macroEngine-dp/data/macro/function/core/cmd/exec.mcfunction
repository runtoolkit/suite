# macro:core/cmd/exec
# Bridges macro:input cmd → macro:engine tools_trigger → dispatch.
# Called only when macro:input cmd exists.

data modify storage macro:engine tools_trigger set from storage macro:input cmd
function macro:debug/tools/trigger/internal/dispatch
data remove storage macro:engine tools_trigger
data remove storage macro:input cmd
