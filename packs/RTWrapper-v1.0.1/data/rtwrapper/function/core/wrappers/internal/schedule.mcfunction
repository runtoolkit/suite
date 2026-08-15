# RTWrapper generated named-parameter dispatcher for /schedule.
# Provide contiguous parameters in this order:
# action, function_id, time, mode
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.function_id run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.time run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.mode run scoreboard players set #pc rtw.status 4
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/schedule_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/schedule_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/schedule_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/schedule_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/schedule_4 with storage rtwrapper:runtime current.params
