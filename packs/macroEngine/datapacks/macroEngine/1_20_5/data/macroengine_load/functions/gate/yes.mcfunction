# macroengine_load:gate/yes
# Confirms the pending gated action and runs it.
# Only players with macroengine.admin may call this directly — vanilla target
# selectors cannot query real op/permission level, so the tag is the trust
# boundary here (same one load/other.mcfunction already uses for
# macroengine_menu/macroengine_run/macroengine_action).

execute unless entity @s[tag=macroengine.admin] run return 0
execute unless data storage macroengine:engine pending_gate run return 0

schedule clear macroengine_load:gate/timeout

function macroengine:core/internal/gate/run_action with storage macroengine:engine pending_gate
data remove storage macroengine:engine pending_gate
