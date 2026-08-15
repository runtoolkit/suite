# RTWrapper generated named-parameter dispatcher for /warden_spawn_tracker.
# Provide contiguous parameters in this order:
# target
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/warden_spawn_tracker_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/warden_spawn_tracker_1 with storage rtwrapper:runtime current.params
