# RTWrapper generated named-parameter dispatcher for /transfer.
# Provide contiguous parameters in this order:
# hostname, port, players
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.hostname run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.port run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.players run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/transfer_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/transfer_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/transfer_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/transfer_3 with storage rtwrapper:runtime current.params
