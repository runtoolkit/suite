# RTWrapper generated named-parameter dispatcher for /fetchprofile.
# Provide contiguous parameters in this order:
# name
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.name run scoreboard players set #pc rtw.status 1
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/fetchprofile_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/fetchprofile_1 with storage rtwrapper:runtime current.params
