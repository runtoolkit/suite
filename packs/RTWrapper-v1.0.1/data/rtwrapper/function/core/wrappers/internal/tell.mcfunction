# RTWrapper generated named-parameter dispatcher for /tell.
# Provide contiguous parameters in this order:
# target, message
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.message run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/tell_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/tell_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/tell_2 with storage rtwrapper:runtime current.params
