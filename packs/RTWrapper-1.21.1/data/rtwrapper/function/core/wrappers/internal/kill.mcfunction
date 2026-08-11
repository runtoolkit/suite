# RTWrapper generated named-parameter dispatcher for /kill.
# Provide contiguous parameters in this order:
# targets
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/kill_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/kill_1 with storage rtwrapper:runtime current.params
