# RTWrapper generated named-parameter dispatcher for /publish.
# Provide contiguous parameters in this order:
# allow_commands, gamemode, port
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.allow_commands run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.gamemode run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.port run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/publish_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/publish_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/publish_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/publish_3 with storage rtwrapper:runtime current.params
