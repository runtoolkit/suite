# RTWrapper generated named-parameter dispatcher for /random.
# Provide contiguous parameters in this order:
# action, range, sequence
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.range run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.sequence run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/random_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/random_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/random_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/random_3 with storage rtwrapper:runtime current.params
