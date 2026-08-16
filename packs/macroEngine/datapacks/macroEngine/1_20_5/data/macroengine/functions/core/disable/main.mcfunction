# Gated disable: if the gate system is active (macroengine:engine sandbox:1b,
# the default), route through confirmation instead of disabling
# immediately. If gates were turned off via gate/toggle/disable, apply
# directly like before.
execute if data storage macroengine:engine {sandbox:1b} run return run function macroengine_load:gate/request {type:"disable",label:"Disable macroengine",action:"macroengine:core/internal/disable/apply",args:{}}

function macroengine:core/internal/disable/apply
