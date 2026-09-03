# runtoolkit:killswitch/all_step
# Internal recursive walker for killswitch/all. Calls each registered
# subsystem's own disable_fn (its normal, gated /disable entry point) —
# does not force-disable via `datapack disable` directly, so each
# subsystem's own confirmation/sandbox/cleanup logic still runs.
# Already-disabled subsystems (version score 0) are skipped.

execute unless data storage runtoolkit:tmp _walk[0] run return 0

data modify storage runtoolkit:tmp _ks_call set from storage runtoolkit:tmp _walk[0]
function runtoolkit:killswitch/all_read_version with storage runtoolkit:tmp _ks_call

execute if score $ks_ver runtoolkit.tmp matches 1.. run function runtoolkit:killswitch/all_dispatch with storage runtoolkit:tmp _ks_call
execute if score $ks_ver runtoolkit.tmp matches ..0 run tellraw @s ["",{"text":"  ","color":"#555555"},{"nbt":"_walk[0].name","storage":"runtoolkit:tmp","color":"gray"},{"text":" — already disabled, skipped","color":"#555555"}]

data remove storage runtoolkit:tmp _walk[0]
function runtoolkit:killswitch/all_step
