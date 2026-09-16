# Page 1 – Tools

# slot 1: label_1 (label)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.1 with minecraft:name_tag[custom_name={text:"— Tools & State —",italic:false,color:"gold",bold:true},custom_data={guigen:{ui:1}}]

# slot 0: toggle_nv (toggle)
execute if score @s guigen_toggle_nv matches 0 run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.0 with minecraft:gray_dye[custom_name={text:"Night Vision: OFF",italic:false,color:"dark_gray"},lore=[{text:"Shift-click to enable",italic:false,color:"gray"}],custom_data={guigen:{action:"toggle_nv"}}]
execute if score @s guigen_toggle_nv matches 1 run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.0 with minecraft:lime_dye[custom_name={text:"Night Vision: ON",italic:false,color:"green"},lore=[{text:"Shift-click to disable",italic:false,color:"gray"}],custom_data={guigen:{action:"toggle_nv"}}]

# slot 2: set_day (button)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.2 with minecraft:sunflower[custom_name={text:"Set Day",italic:false,color:"gold"},custom_data={guigen:{action:"set_day"}}]

# slot 3: set_night (button)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.3 with minecraft:black_dye[custom_name={text:"Set Night",italic:false,color:"dark_purple"},custom_data={guigen:{action:"set_night"}}]

# slot 9: level_dec (counter)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.9 with minecraft:red_concrete[custom_name={text:"− Level",italic:false,color:"red"},lore=[{text:"Adjust guigen_level",italic:false,color:"gray"}],custom_data={guigen:{action:"level_dec"}}]

# slot 10: label_10 (label)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.10 with minecraft:experience_bottle[custom_name={text:"Level (see actionbar/chat)",italic:false,color:"aqua"},lore=[{text:"Adjusted by − / + buttons",italic:false,color:"gray"}],custom_data={guigen:{ui:1}}]

# slot 11: level_inc (counter)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.11 with minecraft:lime_concrete[custom_name={text:"+ Level",italic:false,color:"green"},lore=[{text:"Adjust guigen_level",italic:false,color:"gray"}],custom_data={guigen:{action:"level_inc"}}]

# slot 18: progress_guigen_level (progress)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.18 with minecraft:gray_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
execute if score @s guigen_level matches 1.. run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.18 with minecraft:lime_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.19 with minecraft:gray_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
execute if score @s guigen_level matches 3.. run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.19 with minecraft:lime_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.20 with minecraft:gray_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
execute if score @s guigen_level matches 5.. run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.20 with minecraft:lime_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.21 with minecraft:gray_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
execute if score @s guigen_level matches 7.. run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.21 with minecraft:lime_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.22 with minecraft:gray_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]
execute if score @s guigen_level matches 9.. run item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.22 with minecraft:lime_stained_glass_pane[custom_name={text:"Level bar",italic:false,color:"green"},custom_data={guigen:{ui:1}}]

# slot 6: page_prev (nav)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.6 with minecraft:arrow[custom_name={text:"← Previous",italic:false,color:"yellow"},custom_data={guigen:{action:"page_prev"}}]

# slot 8: close_menu (close)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.8 with minecraft:barrier[custom_name={text:"Close Menu",italic:false,color:"red"},lore=[{text:"Close this menu",italic:false,color:"gray"}],custom_data={guigen:{action:"close_menu"}}]
