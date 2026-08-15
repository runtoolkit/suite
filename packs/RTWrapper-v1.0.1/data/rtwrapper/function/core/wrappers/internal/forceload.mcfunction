# RTWrapper generated named-parameter dispatcher for /forceload.
# Provide contiguous parameters in this order:
# action, from_pos, to_pos
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.from_pos run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.to_pos run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/forceload_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/forceload_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/forceload_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/forceload_3 with storage rtwrapper:runtime current.params
