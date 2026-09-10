# macroengine:core/internal/load/gate/toggle/disable
# Disables the gate system (macroengine:engine sandbox -> 0b), which means
# dangerous commands stop requiring confirmation. Disabling the gates
# is itself gated — same confirm/cancel/30s flow as ban/kick/disable —
# since turning off the safety net is a dangerous action in its own right.
# Re-enabling (gate/toggle/enable) needs no confirmation.

execute unless entity @s[tag=macroengine.admin] run return 0

function macroengine:core/internal/load/gate/request {type:"gate_bypass",label:"Disable gate confirmations (dangerous commands will run immediately)",action:"macroengine:core/internal/gate/toggle/disable_apply",args:{}}
