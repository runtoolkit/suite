# RTWrapper generated named-parameter dispatcher for /tellraw.
# Provide contiguous parameters in this order:
# targets, message
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.message run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/tellraw_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/tellraw_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/tellraw_2 with storage rtwrapper:runtime current.params
