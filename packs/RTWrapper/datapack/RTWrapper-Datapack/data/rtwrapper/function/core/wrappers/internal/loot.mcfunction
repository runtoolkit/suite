# RTWrapper generated named-parameter dispatcher for /loot.
# Provide contiguous parameters in this order:
# action, target, target_slot, source_kind, source, tool
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.target_slot run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.source_kind run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.tool run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/loot_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/loot_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/loot_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/loot_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/loot_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/loot_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/loot_6 with storage rtwrapper:runtime current.params
