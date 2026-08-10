# RTWrapper generated named-parameter dispatcher for /fill.
# Provide contiguous parameters in this order:
# from_pos, to_pos, block, mode, filter
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.from_pos run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.to_pos run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.block run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.mode run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.filter run scoreboard players set #pc rtw.status 5
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/fill_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/fill_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/fill_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/fill_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/fill_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/fill_5 with storage rtwrapper:runtime current.params
