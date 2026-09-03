# runtoolkit:registry/list
# Reports the subsystems currently registered with runtoolkit's global
# load/tick dispatcher. Registration happens via runtoolkit:registry/register
# (called once per subsystem, e.g. from macroengine's own load chain) —
# this function only reads and prints what is already in storage.
#
# Storage shape (runtoolkit:engine):
#   registry.subsystems = [
#     {name:"macroengine", version:610, load_fn:"macroengine:setup", tick_fn:"macroengine.main:macroengine/tick"},
#     ...
#   ]

execute unless data storage runtoolkit:engine registry run data modify storage runtoolkit:engine registry set value {}
execute unless data storage runtoolkit:engine registry.subsystems run data modify storage runtoolkit:engine registry.subsystems set value []

execute unless data storage runtoolkit:engine registry.subsystems[0] run tellraw @s ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"registry is empty — no subsystems registered.","color":"gray"}]
execute unless data storage runtoolkit:engine registry.subsystems[0] run return 0

tellraw @s ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"registered subsystems:","color":"aqua"}]
data modify storage runtoolkit:tmp _walk set from storage runtoolkit:engine registry.subsystems
function runtoolkit:registry/list_step
data remove storage runtoolkit:tmp _walk
