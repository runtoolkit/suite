# RTWrapper generated named-parameter dispatcher for /teleport.
# Provide contiguous parameters in this order:
# target, x, y, z, rotation, facing_mode, facing_target, facing_anchor
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.x run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.y run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.z run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.rotation run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.facing_mode run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.facing_target run scoreboard players set #pc rtw.status 7
execute if data storage rtwrapper:runtime current.params.facing_anchor run scoreboard players set #pc rtw.status 8
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/teleport_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/teleport_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/teleport_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/teleport_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/teleport_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/teleport_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/teleport_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/teleport_7 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 8 run function rtwrapper:core/wrappers/internal/variants/teleport_8 with storage rtwrapper:runtime current.params
