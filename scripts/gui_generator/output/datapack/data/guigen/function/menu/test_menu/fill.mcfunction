# Auto-generated – clear slots then route to current page
execute as @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] run data modify entity @s Items set value []

execute if score @s guigen_page matches 0 run function guigen:menu/test_menu/fill_page0
execute if score @s guigen_page matches 1 run function guigen:menu/test_menu/fill_page1
execute if score @s guigen_page matches 2 run function guigen:menu/test_menu/fill_page2
