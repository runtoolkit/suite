# RTWrapper generated named-parameter dispatcher for /data.
# Provide contiguous parameters in this order:
# action, target_kind, target, path, operation, source_kind, source, source_path, value
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.target_kind run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.path run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.operation run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.source_kind run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 7
execute if data storage rtwrapper:runtime current.params.source_path run scoreboard players set #pc rtw.status 8
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 9
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/data_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/data_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/data_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/data_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/data_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/data_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/data_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/data_7 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 8 run function rtwrapper:core/wrappers/internal/variants/data_8 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 9 run function rtwrapper:core/wrappers/internal/variants/data_9 with storage rtwrapper:runtime current.params
