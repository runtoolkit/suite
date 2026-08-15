# RTWrapper generated named-parameter dispatcher for /team.
# Provide contiguous parameters in this order:
# action, team, display_name, option, value, targets
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.team run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.display_name run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.option run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/team_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/team_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/team_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/team_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/team_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/team_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/team_6 with storage rtwrapper:runtime current.params
