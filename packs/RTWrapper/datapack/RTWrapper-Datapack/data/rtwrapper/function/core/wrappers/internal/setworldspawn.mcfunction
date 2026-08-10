# RTWrapper generated named-parameter dispatcher for /setworldspawn.
# Provide contiguous parameters in this order:
# pos, angle
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.angle run scoreboard players set #pc rtw.status 2
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/setworldspawn_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/setworldspawn_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/setworldspawn_2 with storage rtwrapper:runtime current.params
