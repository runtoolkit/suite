# RTWrapper generated named-parameter dispatcher for /particle.
# Provide contiguous parameters in this order:
# particle, pos, delta, speed, count, mode, viewers
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.particle run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.pos run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.delta run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.speed run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.count run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.mode run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.viewers run scoreboard players set #pc rtw.status 7
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/particle_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/particle_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/particle_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/particle_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/particle_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/particle_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/particle_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/particle_7 with storage rtwrapper:runtime current.params
