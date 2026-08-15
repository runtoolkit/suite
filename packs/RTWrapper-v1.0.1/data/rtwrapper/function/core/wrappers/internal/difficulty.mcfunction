# RTWrapper generated named-parameter dispatcher for /difficulty.
# Provide contiguous parameters in this order:
# difficulty
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.difficulty run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/difficulty_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/difficulty_1 with storage rtwrapper:runtime current.params
