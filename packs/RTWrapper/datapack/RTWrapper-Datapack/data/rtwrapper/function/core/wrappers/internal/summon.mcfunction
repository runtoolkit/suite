# RTWrapper generated named-parameter dispatcher for /summon.
# Provide contiguous parameters in this order:
# entity, pos, nbt
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.entity run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.nbt run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/summon_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/summon_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/summon_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/summon_3 with storage rtwrapper:runtime current.params
