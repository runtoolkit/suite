# RTWrapper generated named-parameter dispatcher for /save-all.
# Provide contiguous parameters in this order:
# flush
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.flush run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/save-all_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/save-all_1 with storage rtwrapper:runtime current.params
