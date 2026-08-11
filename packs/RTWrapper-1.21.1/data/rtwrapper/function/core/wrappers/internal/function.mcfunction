# RTWrapper generated named-parameter dispatcher for /function.
# Provide contiguous parameters in this order:
# function_id, mode, source, path
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.function_id run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.mode run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.path run scoreboard players set #pc rtw.status 4
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/function_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/function_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/function_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/function_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/function_4 with storage rtwrapper:runtime current.params
