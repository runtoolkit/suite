# macroengine:systems/hook/internal/check_bind [MACRO]
# INPUT: $(event) - event field of the bind in _hook_ctx
# If it matches _hook_fire_event, run func or cmd.
# @s = the triggering player

$execute if data storage macroengine:engine {_hook_fire_event:"$(event)"} if data storage macroengine:engine _hook_ctx.func run function macroengine:core/internal/systems/hook/exec with storage macroengine:engine _hook_ctx
$execute if data storage macroengine:engine {_hook_fire_event:"$(event)"} unless data storage macroengine:engine _hook_ctx.func run function macroengine:core/internal/systems/hook/run_cmd with storage macroengine:engine _hook_ctx
