# macroengine:systems/hook/internal/dispatch
# Iterates _hook_iter list, runs matching events.

execute unless data storage macroengine:engine _hook_iter[0] run return 0

data modify storage macroengine:engine _hook_ctx set from storage macroengine:engine _hook_iter[0]
data remove storage macroengine:engine _hook_iter[0]

function macroengine:core/internal/systems/hook/check_bind with storage macroengine:engine _hook_ctx

function macroengine:core/internal/systems/hook/dispatch
