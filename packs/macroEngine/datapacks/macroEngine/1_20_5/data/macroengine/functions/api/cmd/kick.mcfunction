# Gated kick: if the gate system is active (macroengine:engine sandbox:1b, the
# default), route through confirmation. If gates were turned off via
# gate/toggle/disable, apply directly like before.
#
# INPUT : $(player) -> exact player name, $(reason) -> kick reason
$execute if data storage macroengine:engine {sandbox:1b} run return run function macroengine_load:gate/request {type:"kick",label:"Kick $(player) — $(reason)",action:"macroengine:core/internal/cmd/kick_apply",args:{player:"$(player)",reason:"$(reason)"}}

$function macroengine:core/internal/cmd/kick_apply {player:"$(player)",reason:"$(reason)"}
