# macroengine_load:gate/request
# Starts a confirm/cancel gated action. Any dangerous action (ban, kick,
# disable, sandbox toggle-off, ...) should route through here instead of
# executing immediately.
#
# INPUT (macro — all four required; pass args:{} for no-arg actions):
#   $(type)   -> gate type, e.g. "disable", "ban", "kick", "gate_bypass"
#   $(label)  -> human-readable text shown in the confirm prompt
#   $(action) -> function to run on confirm, e.g. "macroengine:core/disable/main"
#   $(args)   -> compound of macro args passed to $(action) via
#                run_action_with_args, e.g. {player:"Steve",reason:"x"}.
#                Pass {} for actions that take no arguments.
#
# A single global pending_gate slot is used. If a second request comes in
# while one is already pending, the new request is dropped and the
# collision is logged — the original request keeps priority.
#
# KNOWN LIMITATION (not fixed here, pre-existing):
# Callers write to storage before gate/request's own #pending check runs,
# so a second caller can still race the check under concurrent execution.
# This affects all gate types, not just this one.

execute if data storage macroengine:engine pending_gate run return run function macroengine_load:gate/collision

$data modify storage macroengine:engine pending_gate.type set value "$(type)"
$data modify storage macroengine:engine pending_gate.label set value "$(label)"
$data modify storage macroengine:engine pending_gate.action set value "$(action)"
$data modify storage macroengine:engine pending_gate.args set value $(args)

tellraw @a[tag=macroengine.admin] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Confirmation required: ","color":"yellow"},{"nbt":"pending_gate.label","storage":"macroengine:engine","color":"white"}," ",{"text":"[Confirm]","color":"green","bold":true,"click_event":{"action":"run_command","command":"/function macroengine_load:gate/yes"}}," ",{"text":"[Cancel]","color":"red","bold":true,"click_event":{"action":"run_command","command":"/function macroengine_load:gate/no"}}," ",{"text":"(30s)","color":"gray"}]

schedule function macroengine_load:gate/timeout 30s
