# macroengine:core/cmd/exec
# Bridges macroengine:input cmd → macroengine:engine tools_trigger → dispatch.
# Called only when macroengine:input cmd exists.

data modify storage macroengine:engine tools_trigger set from storage macroengine:input cmd
function macroengine:core/internal/debug/tools/trigger/dispatch
data remove storage macroengine:engine tools_trigger
data remove storage macroengine:input cmd
