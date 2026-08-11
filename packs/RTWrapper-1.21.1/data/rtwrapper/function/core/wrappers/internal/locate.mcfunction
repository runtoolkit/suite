# RTWrapper generated named-parameter dispatcher for /locate.
# Provide contiguous parameters in this order:
# category, id
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.category run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.id run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/locate_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/locate_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/locate_2 with storage rtwrapper:runtime current.params
