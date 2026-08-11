# RTWrapper generated named-parameter dispatcher for /bossbar.
# Provide contiguous parameters in this order:
# action, id, name, property, value, players
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.id run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.name run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.property run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.players run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/bossbar_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/bossbar_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/bossbar_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/bossbar_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/bossbar_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/bossbar_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/bossbar_6 with storage rtwrapper:runtime current.params
