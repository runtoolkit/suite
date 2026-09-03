# macroengine:systems/hook/internal/bind_exec [MACRO]
# INPUT: $(event) - required
# macroengine:input.func OR macroengine:input.cmd - one must exist
#
# Two-step: append a base compound with just event, then set func or cmd from storage.
# This avoids requiring both $(func) and $(cmd) to be present simultaneously.

$data modify storage macroengine:engine hook_binds append value {event:"$(event)"}
execute if data storage macroengine:input func run data modify storage macroengine:engine hook_binds[-1].func set from storage macroengine:input func
execute unless data storage macroengine:input func run data modify storage macroengine:engine hook_binds[-1].cmd set from storage macroengine:input cmd

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"hook/bind ","color":"aqua"},{"text":"$(event)","color":"yellow"}]
