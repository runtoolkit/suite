# RTWrapper generated named-parameter dispatcher for /title.
# Provide contiguous parameters in this order:
# targets, action, title, fade_in, stay, fade_out
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.title run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.fade_in run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.stay run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.fade_out run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/title_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/title_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/title_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/title_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/title_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/title_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/title_6 with storage rtwrapper:runtime current.params
