# Page 2 – Confirm

# slot 1: label_1 (label)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.1 with minecraft:name_tag[custom_name={text:"Teleport to 0, 100, 0 ?",italic:false,color:"gold"},custom_data={guigen:{ui:1}}]

# slot 0: separator_0 (separator)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.0 with minecraft:gray_stained_glass_pane[custom_name={text:" ",italic:false,color:"dark_gray"},custom_data={guigen:{ui:1}}]

# slot 2: separator_2 (separator)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.2 with minecraft:gray_stained_glass_pane[custom_name={text:" ",italic:false,color:"dark_gray"},custom_data={guigen:{ui:1}}]

# slot 3: teleport_spawn (button)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.3 with minecraft:lime_concrete[custom_name={text:"CONFIRM",italic:false,color:"green"},custom_data={guigen:{action:"teleport_spawn"}}]

# slot 5: page_main (nav)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.5 with minecraft:red_concrete[custom_name={text:"CANCEL",italic:false,color:"red"},custom_data={guigen:{action:"page_main"}}]
