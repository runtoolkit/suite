# RTWrapper generated named-parameter dispatcher for /tick.
# Provide contiguous parameters in this order:
# action, value
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/tick_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/tick_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/tick_2 with storage rtwrapper:runtime current.params
