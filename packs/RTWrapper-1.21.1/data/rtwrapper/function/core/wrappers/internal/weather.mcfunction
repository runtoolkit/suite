# RTWrapper generated named-parameter dispatcher for /weather.
# Provide contiguous parameters in this order:
# weather, duration
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.weather run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.duration run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/weather_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/weather_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/weather_2 with storage rtwrapper:runtime current.params
