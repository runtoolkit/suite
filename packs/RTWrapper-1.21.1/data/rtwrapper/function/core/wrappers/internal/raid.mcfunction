# RTWrapper generated named-parameter dispatcher for /raid.
# Provide contiguous parameters in this order:
# action
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/raid_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/raid_1 with storage rtwrapper:runtime current.params
