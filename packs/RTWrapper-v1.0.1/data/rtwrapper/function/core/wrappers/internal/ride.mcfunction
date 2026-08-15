# RTWrapper generated named-parameter dispatcher for /ride.
# Provide contiguous parameters in this order:
# target, action, vehicle
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.vehicle run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/ride_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/ride_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/ride_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/ride_3 with storage rtwrapper:runtime current.params
