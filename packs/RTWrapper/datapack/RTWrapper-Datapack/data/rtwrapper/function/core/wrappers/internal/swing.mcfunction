# RTWrapper generated named-parameter dispatcher for /swing.
# Provide contiguous parameters in this order:
# target, hand
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.hand run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/swing_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/swing_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/swing_2 with storage rtwrapper:runtime current.params
