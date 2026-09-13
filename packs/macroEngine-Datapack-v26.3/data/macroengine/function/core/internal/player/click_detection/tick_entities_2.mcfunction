
execute store result score #temp player_action.data if entity @a[distance=..10,tag=player_action.click_detection]
execute if score #temp player_action.data matches 0 run tp @s ~ -300 ~
execute if score #temp player_action.data matches 0 run kill @s
