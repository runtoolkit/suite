# Page 0 – Main

# slot 1: label_1 (label)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.1 with minecraft:name_tag[custom_name={text:"— Main Menu —",italic:false,color:"gold",bold:true},lore=[{text:"GUI-GENERATOR demo",italic:false,color:"gray"}],custom_data={guigen:{ui:1}}]

# slot 0: goto_confirm_tp (confirm)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.0 with minecraft:compass[custom_name={text:"Teleport to Spawn",italic:false,color:"aqua"},lore=[{text:"Opens confirmation page",italic:false,color:"gray"}],custom_data={guigen:{action:"goto_confirm_tp"}}]

# slot 2: heal (button)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.2 with minecraft:golden_apple[custom_name={text:"Heal & Feed",italic:false,color:"green"},lore=[{text:"Fully restore health and hunger",italic:false,color:"gray"}],custom_data={guigen:{action:"heal"}}]

# slot 4: give_diamond (button)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.4 with minecraft:nether_star[custom_name={text:"Give Diamond",italic:false,color:"light_purple"},lore=[{text:"Only if you have < 5 diamonds",italic:false,color:"gray"}],custom_data={guigen:{action:"give_diamond"}}]

# slot 3: separator_3 (separator)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.3 with minecraft:gray_stained_glass_pane[custom_name={text:" ",italic:false,color:"dark_gray"},custom_data={guigen:{ui:1}}]

# slot 5: separator_5 (separator)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.5 with minecraft:gray_stained_glass_pane[custom_name={text:" ",italic:false,color:"dark_gray"},custom_data={guigen:{ui:1}}]

# slot 6: page_next (nav)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.6 with minecraft:arrow[custom_name={text:"Next Page →",italic:false,color:"yellow"},lore=[{text:"Tools, toggles, counters",italic:false,color:"gray"}],custom_data={guigen:{action:"page_next"}}]

# slot 8: close_menu (close)
item replace entity @e[type=minecraft:chest_minecart,tag=guigen.test_menu,distance=..8,sort=nearest,limit=1] container.8 with minecraft:barrier[custom_name={text:"Close Menu",italic:false,color:"red"},lore=[{text:"Close this menu",italic:false,color:"gray"}],custom_data={guigen:{action:"close_menu"}}]
