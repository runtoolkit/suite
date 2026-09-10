scoreboard players set @s macroengine.dialog_load -1
tag @s remove macroengine.dialog_closed
tag @s remove macroengine.dialog_opened

execute unless data storage macroengine:engine dialog.DIALOG run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Dialog not found","color":"red","bold":false,"italic":false}]}}
execute if data storage macroengine:engine {dialog:{DIALOG:""}} run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Unknown dialog","color":"red","bold":false,"italic":false}]}}
execute unless data storage macroengine:engine dialog.DIALOG.type run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Unknown dialog type","color":"red","bold":false,"italic":false}]}}
execute unless data storage macroengine:engine dialog.DIALOG.title run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Missing dialog title","color":"red","bold":false,"italic":false}]}}
execute if data storage macroengine:engine {dialog:{DIALOG:{type:"multi_action"}}} unless data storage macroengine:engine dialog.DIALOG.actions run return run dialog show @s {"type":"multi_action","title":"","actions":[{"label":"Ok"}],"pause":false,"after_action":"close","body":{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Missing actions","color":"red","bold":false,"italic":false}]}}

execute if data storage macroengine:engine dialog.DIALOG run function macroengine:api/dialog/show
execute if data storage macroengine:engine dialog.DIALOG run function macroengine:api/dialog/notify_admins
