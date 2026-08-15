# RTWrapper generated named-parameter dispatcher for /scoreboard.
# Provide contiguous parameters in this order:
# category, action, subject, objective, value, operation, source, source_objective
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.category run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.subject run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.objective run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.operation run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 7
execute if data storage rtwrapper:runtime current.params.source_objective run scoreboard players set #pc rtw.status 8
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/scoreboard_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/scoreboard_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/scoreboard_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/scoreboard_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/scoreboard_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/scoreboard_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/scoreboard_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/scoreboard_7 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 8 run function rtwrapper:core/wrappers/internal/variants/scoreboard_8 with storage rtwrapper:runtime current.params
