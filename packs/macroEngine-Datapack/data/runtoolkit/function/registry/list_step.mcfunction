# runtoolkit:registry/list_step
# Internal recursive walker for registry/list. Pops entries off
# runtoolkit:tmp _walk (a scratch copy) one at a time so the source
# registry.subsystems list is never mutated by listing it.

execute unless data storage runtoolkit:tmp _walk[0] run return 0

execute store result score $reg_ver runtoolkit.tmp run data get storage runtoolkit:tmp _walk[0].version
execute if score $reg_ver runtoolkit.tmp matches 1.. run tellraw @s ["",{"text":"  - ","color":"#555555"},{"nbt":"_walk[0].name","storage":"runtoolkit:tmp","color":"white"},{"text":" (v","color":"#555555"},{"nbt":"_walk[0].version","storage":"runtoolkit:tmp","color":"green"},{"text":")","color":"#555555"}]
execute if score $reg_ver runtoolkit.tmp matches ..0 run tellraw @s ["",{"text":"  - ","color":"#555555"},{"nbt":"_walk[0].name","storage":"runtoolkit:tmp","color":"gray"},{"text":" (disabled)","color":"red"}]

data remove storage runtoolkit:tmp _walk[0]
function runtoolkit:registry/list_step
