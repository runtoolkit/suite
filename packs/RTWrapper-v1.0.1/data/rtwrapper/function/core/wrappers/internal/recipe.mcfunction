# RTWrapper generated named-parameter dispatcher for /recipe.
# Provide contiguous parameters in this order:
# action, targets, recipe
scoreboard players set #pc rtw.status 0
execute if data storage rtwrapper:runtime current.params.action run scoreboard players set #pc rtw.status 1
execute if data storage rtwrapper:runtime current.params.targets run scoreboard players set #pc rtw.status 2
execute if data storage rtwrapper:runtime current.params.recipe run scoreboard players set #pc rtw.status 3
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/recipe_0
execute if score #pc rtw.status matches 1 run function rtwrapper:core/wrappers/internal/variants/recipe_1 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 2 run function rtwrapper:core/wrappers/internal/variants/recipe_2 with storage rtwrapper:runtime current.params
execute if score #pc rtw.status matches 3 run function rtwrapper:core/wrappers/internal/variants/recipe_3 with storage rtwrapper:runtime current.params
