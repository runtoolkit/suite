playsound minecraft:block.note_block.pling master @s ~ ~ ~ 4 2

function macroengine:core/disable/main

tellraw @s [{"text":"To restart:"}," ",{"text":"/datapack enable 'file/macroengine.zip'","color":"aqua","bold":true,"italic":false,"clickEvent":{"action": "run_command", "value":"/datapack enable 'file/macroengine.zip'"}},", ",{"text":"/datapack enable 'file/macroengine'","color":"aqua","bold":true,"italic":false,"clickEvent":{"action": "run_command", "value":"/datapack enable 'file/macroengine'"}}," or",{"text":"/datapack enable 'file/macroengine-full.zip'","color":"aqua","bold":true,"italic":false,"clickEvent":{"action": "run_command", "value":"/datapack enable 'file/macroengine-full.zip'"}}]
