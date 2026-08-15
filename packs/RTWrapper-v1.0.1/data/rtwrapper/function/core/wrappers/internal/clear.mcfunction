# RTWrapper generated named-parameter dispatcher for /clear.
# Provide contiguous parameters in this order:
# targets, item, max_count
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.item run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.max_count run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/clear_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/clear_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/clear_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/clear_3 with storage rtwrapper:runtime current.params
