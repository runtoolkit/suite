# RTWrapper generated named-parameter dispatcher for /enchant.
# Provide contiguous parameters in this order:
# targets, enchantment, level
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.enchantment run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.level run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/enchant_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/enchant_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/enchant_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/enchant_3 with storage rtwrapper:runtime current.params
