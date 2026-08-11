# RTWrapper generated named-parameter dispatcher for /spreadplayers.
# Provide contiguous parameters in this order:
# center, spread_distance, max_range, height_mode, respect_teams, targets
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.center run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.spread_distance run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.max_range run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.height_mode run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.respect_teams run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/spreadplayers_6 with storage rtwrapper:runtime current.params
