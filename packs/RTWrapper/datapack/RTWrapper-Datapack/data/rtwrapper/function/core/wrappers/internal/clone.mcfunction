# RTWrapper generated named-parameter dispatcher for /clone.
# Provide contiguous parameters in this order:
# begin, end, destination, mask_mode, clone_mode, filter
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.begin run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.end run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.destination run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.mask_mode run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.clone_mode run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.filter run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/clone_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/clone_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/clone_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/clone_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/clone_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/clone_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/clone_6 with storage rtwrapper:runtime current.params
