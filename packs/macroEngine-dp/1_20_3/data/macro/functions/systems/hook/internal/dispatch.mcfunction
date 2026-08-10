# macro:systems/hook/internal/dispatch
# Iterates _hook_iter list, runs matching events.

execute unless data storage macro:engine _hook_iter[0] run return 0

data modify storage macro:engine _hook_ctx set from storage macro:engine _hook_iter[0]
data remove storage macro:engine _hook_iter[0]

function macro:systems/hook/internal/check_bind with storage macro:engine _hook_ctx

function macro:systems/hook/internal/dispatch
