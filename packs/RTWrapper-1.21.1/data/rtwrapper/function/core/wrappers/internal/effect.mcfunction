# RTWrapper generated named-parameter dispatcher for /effect.
# Provide contiguous parameters in this order:
# action, targets, effect, duration, amplifier, hide_particles
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.effect run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.duration run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.amplifier run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.hide_particles run scoreboard players set #pc rtw.status 6
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/effect_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/effect_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/effect_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/effect_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/effect_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/effect_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/effect_6 with storage rtwrapper:runtime current.params
