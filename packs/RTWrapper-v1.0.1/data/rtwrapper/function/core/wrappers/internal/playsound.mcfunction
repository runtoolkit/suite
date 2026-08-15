# RTWrapper generated named-parameter dispatcher for /playsound.
# Provide contiguous parameters in this order:
# sound, source, targets, pos, volume, pitch, min_volume
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.sound run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.source run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.volume run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.pitch run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.min_volume run scoreboard players set #pc rtw.status 7
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/playsound_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/playsound_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/playsound_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/playsound_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/playsound_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/playsound_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/playsound_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/playsound_7 with storage rtwrapper:runtime current.params
