# Gated storage removal: if the gate system is active (macroengine:engine
# sandbox:1b, the default), route through confirmation — this command can
# destroy arbitrary storage data (including macroengine's own engine state) so
# it is treated as dangerous. If gates were turned off via
# gate/toggle/disable, apply directly like before.
#
# INPUT : $(storage) -> storage id, e.g. "macroengine:engine"
# $(path) -> NBT path to remove, e.g. "pending_gate"
$execute if data storage macroengine:engine {sandbox:1b} run return run function macroengine_load:gate/request {type:"data_remove_storage",label:"Remove storage $(storage) → $(path)",action:"macroengine:core/internal/cmd/data_remove_storage_apply",args:{storage:"$(storage)",path:"$(path)"}}

$function macroengine:core/internal/cmd/data_remove_storage_apply {storage:"$(storage)",path:"$(path)"}
