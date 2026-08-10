# RTWrapper generated named-parameter dispatcher for /spawnpoint.
# Provide contiguous parameters in this order:
# targets, pos, angle
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.angle run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/spawnpoint_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/spawnpoint_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/spawnpoint_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/spawnpoint_3 with storage rtwrapper:runtime current.params
