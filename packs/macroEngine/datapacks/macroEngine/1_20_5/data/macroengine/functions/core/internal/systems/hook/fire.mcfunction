# macroengine:systems/hook/internal/fire [MACRO]
# INPUT: $(event) — event name to fire
# @s = the triggering player
# Copies hook_binds list and dispatches it.

$data modify storage macroengine:engine _hook_fire_event set value "$(event)"
data modify storage macroengine:engine _hook_iter set from storage macroengine:engine hook_binds

execute if data storage macroengine:engine _hook_iter run function macroengine:core/internal/systems/hook/dispatch

data remove storage macroengine:engine _hook_iter
data remove storage macroengine:engine _hook_fire_event
