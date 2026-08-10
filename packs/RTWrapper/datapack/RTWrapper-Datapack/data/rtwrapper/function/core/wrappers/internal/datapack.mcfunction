# RTWrapper generated named-parameter dispatcher for /datapack.
# Provide contiguous parameters in this order:
# action, name, position, anchor
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.name run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.position run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.anchor run scoreboard players set #pc rtw.status 4
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/datapack_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/datapack_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/datapack_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/datapack_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/datapack_4 with storage rtwrapper:runtime current.params
