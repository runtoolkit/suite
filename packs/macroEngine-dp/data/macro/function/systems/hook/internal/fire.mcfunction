# macro:systems/hook/internal/fire [MACRO]
# INPUT: $(event) — event name to fire
# @s = the triggering player
# Copies hook_binds list and dispatches it.

$data modify storage macro:engine _hook_fire_event set value "$(event)"
data modify storage macro:engine _hook_iter set from storage macro:engine hook_binds

execute if data storage macro:engine _hook_iter run function macro:systems/hook/internal/dispatch

data remove storage macro:engine _hook_iter
data remove storage macro:engine _hook_fire_event
