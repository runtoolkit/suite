# macroengine:core/internal/load/force
# Gated force reload: if the gate system is active (macroengine:engine
# sandbox:1b, the default), route through confirmation — force reload
# discards live engine state (global.loaded and everything load/all's
# "unless data" guards would otherwise preserve), so it is a dangerous
# action in the same class as ban/kick/disable. If gates were turned
# off via gate/toggle/disable, apply directly like before.

execute if data storage macroengine:engine {sandbox:1b} run return run function macroengine:core/internal/load/gate/request {type:"load_force",label:"Force reload macroengine (discards live engine state)",action:"macroengine:core/internal/load/force_apply",args:{}}

function macroengine:core/internal/load/force_apply
