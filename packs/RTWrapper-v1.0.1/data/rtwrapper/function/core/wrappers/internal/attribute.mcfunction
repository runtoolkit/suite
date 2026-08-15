# RTWrapper generated named-parameter dispatcher for /attribute.
# Provide contiguous parameters in this order:
# target, attribute, action, value, modifier_id, modifier_value, modifier_operation
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.target run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.attribute run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 3
execute if data storage rtwrapper:runtime current.params.value run scoreboard players set #pc rtw.status 4
execute if data storage rtwrapper:runtime current.params.modifier_id run scoreboard players set #pc rtw.status 5
execute if data storage rtwrapper:runtime current.params.modifier_value run scoreboard players set #pc rtw.status 6
execute if data storage rtwrapper:runtime current.params.modifier_operation run scoreboard players set #pc rtw.status 7
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/attribute_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/attribute_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/attribute_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/attribute_3 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 4 run function rtwrapper:core/wrappers/internal/variants/attribute_4 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 5 run function rtwrapper:core/wrappers/internal/variants/attribute_5 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 6 run function rtwrapper:core/wrappers/internal/variants/attribute_6 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 7 run function rtwrapper:core/wrappers/internal/variants/attribute_7 with storage rtwrapper:runtime current.params
