# RTWrapper generated named-parameter dispatcher for /serverpack.
# Provide contiguous parameters in this order:
# action, id, url, hash
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.id run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.url run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.hash run scoreboard players set #pc rtw.status 4
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/serverpack_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/serverpack_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/serverpack_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/serverpack_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/serverpack_4 with storage rtwrapper:runtime current.params
