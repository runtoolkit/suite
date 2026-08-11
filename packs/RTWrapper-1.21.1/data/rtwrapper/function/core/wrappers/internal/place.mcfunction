# RTWrapper generated named-parameter dispatcher for /place.
# Provide contiguous parameters in this order:
# type, id, pos, rotation, mirror, integrity, seed
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.type run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.id run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.rotation run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.mirror run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.integrity run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.seed run scoreboard players set #pc rtw.status 7
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/place_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/place_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/place_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/place_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/place_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/place_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/place_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/place_7 with storage rtwrapper:runtime current.params
