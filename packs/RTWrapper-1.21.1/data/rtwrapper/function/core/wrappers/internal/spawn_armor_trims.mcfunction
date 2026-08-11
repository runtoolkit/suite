# RTWrapper generated named-parameter dispatcher for /spawn_armor_trims.
# Provide contiguous parameters in this order:
# target
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/spawn_armor_trims_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/spawn_armor_trims_1 with storage rtwrapper:runtime current.params
