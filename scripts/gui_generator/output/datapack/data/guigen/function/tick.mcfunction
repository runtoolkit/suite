# Auto-generated tick
# Timer
execute as @a[scores={guigen_menu_timer=1..}] run scoreboard players remove @s guigen_menu_timer 1
execute as @a[scores={guigen_menu_timer=0}] at @s run function guigen:menu/test_menu/close

# Follow + distance safety
execute as @a[scores={guigen_menu_timer=1..}] at @s as @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..6,sort=nearest,limit=1] run tp @s ~ ~ ~
execute as @a[scores={guigen_menu_timer=1..}] at @s unless entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..6,limit=1] run function guigen:menu/test_menu/close

execute as @a[scores={guigen_toggle_nv=1}] run effect give @s minecraft:night_vision infinite 0 true

# Click detection

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:compass[custom_data={guigen:{action:"goto_confirm_tp"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_goto_confirm_tp
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:golden_apple[custom_data={guigen:{action:"heal"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_heal
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:nether_star[custom_data={guigen:{action:"give_diamond"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_give_diamond
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:arrow[custom_data={guigen:{action:"page_next"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_page_next
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:barrier[custom_data={guigen:{action:"close_menu"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_close_menu
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:gray_dye[custom_data={guigen:{action:"toggle_nv"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_toggle_nv
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:lime_dye[custom_data={guigen:{action:"toggle_nv"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_toggle_nv
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:sunflower[custom_data={guigen:{action:"set_day"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_set_day
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:black_dye[custom_data={guigen:{action:"set_night"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_set_night
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:red_concrete[custom_data={guigen:{action:"level_dec"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_level_dec
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:lime_concrete[custom_data={guigen:{action:"level_inc"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_level_inc
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:arrow[custom_data={guigen:{action:"page_prev"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_page_prev
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:lime_concrete[custom_data={guigen:{action:"teleport_spawn"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_teleport_spawn
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

execute as @a[scores={guigen_menu_timer=1..}] store success score @s guigen_click run clear @s minecraft:red_concrete[custom_data={guigen:{action:"page_main"}}] 1
execute as @a[scores={guigen_click=1}] at @s run function guigen:menu/test_menu/on_click_page_main
scoreboard players reset @a[scores={guigen_click=1}] guigen_click

kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{guigen:{}}}}}]
