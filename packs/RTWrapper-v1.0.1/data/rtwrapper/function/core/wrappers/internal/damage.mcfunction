# RTWrapper generated named-parameter dispatcher for /damage.
# Provide contiguous parameters in this order:
# target, amount, damage_type, location_or_by, source, cause
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.amount run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.damage_type run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.location_or_by run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.cause run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/damage_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/damage_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/damage_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/damage_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/damage_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/damage_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/damage_6 with storage rtwrapper:runtime current.params
