# RTWrapper generated named-parameter dispatcher for /setblock.
# Provide contiguous parameters in this order:
# pos, block, mode
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.block run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.mode run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/setblock_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/setblock_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/setblock_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/setblock_3 with storage rtwrapper:runtime current.params
