# RTWrapper generated named-parameter dispatcher for /return.
# Provide contiguous parameters in this order:
# mode, value, command
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.mode run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.command run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/return_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/return_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/return_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/return_3 with storage rtwrapper:runtime current.params
