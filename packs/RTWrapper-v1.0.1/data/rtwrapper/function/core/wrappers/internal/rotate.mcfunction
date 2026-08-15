# RTWrapper generated named-parameter dispatcher for /rotate.
# Provide contiguous parameters in this order:
# target, rotation_or_facing, facing_position, facing_entity, facing_anchor
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.rotation_or_facing run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.facing_position run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.facing_entity run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.facing_anchor run scoreboard players set #pc rtw.status 5
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/rotate_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/rotate_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/rotate_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/rotate_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/rotate_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/rotate_5 with storage rtwrapper:runtime current.params
