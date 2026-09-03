# runtoolkit:registry/load_all_dispatch
# MACRO INPUT (one seed entry, via "with"):
#   $(name), $(load_fn), $(tick_fn), $(disable_fn), $(version_score)
#
# Calls load_fn, reads the resulting live version, then registers.
# version_score is a dynamic scoreboard holder name (e.g.
# "#runtoolkit.packs.macroengine.version") — score holders accept macro
# substitution directly, same pattern as diagnostics/status_line.

$function $(load_fn)

$execute store result score $rt_reg_ver runtoolkit.tmp run scoreboard players get $(version_score) macroengine.meta

data modify storage runtoolkit:tmp _reg set from storage runtoolkit:tmp _load_entry
data remove storage runtoolkit:tmp _reg.version_score
execute store result storage runtoolkit:tmp _reg.version int 1 run scoreboard players get $rt_reg_ver runtoolkit.tmp
function runtoolkit:registry/register with storage runtoolkit:tmp _reg
data remove storage runtoolkit:tmp _reg
