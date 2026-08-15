# RTWrapper generated named-parameter dispatcher for /item.
# Provide contiguous parameters in this order:
# action, target_kind, target, slot, modifier, source_kind, source, source_slot, item, count
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.target_kind run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.slot run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.modifier run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.source_kind run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 7
execute if data storage rtwrapper:runtime current.params.source_slot run scoreboard players set #pc rtw.status 8
execute if data storage rtwrapper:runtime current.params.item run scoreboard players set #pc rtw.status 9
execute if data storage rtwrapper:runtime current.params.count run scoreboard players set #pc rtw.status 10
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/item_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/item_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/item_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/item_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/item_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/item_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/item_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/item_7 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 8 run function rtwrapper:core/wrappers/internal/variants/item_8 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 9 run function rtwrapper:core/wrappers/internal/variants/item_9 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 10 run function rtwrapper:core/wrappers/internal/variants/item_10 with storage rtwrapper:runtime current.params
