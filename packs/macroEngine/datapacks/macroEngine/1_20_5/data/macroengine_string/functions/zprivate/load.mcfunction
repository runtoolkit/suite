# Init
scoreboard objectives add StringLib dummy
execute unless score #StringLib.Init StringLib matches 1 run function macroengine_string:zprivate/init

# Tellraw
execute if score #StringLib.ShowLoadMessage StringLib matches 1 run tellraw @a ["﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},{"text":"Made by CMDred","clickEvent":{"action":"open_url","value":"https://www.youtube.com/BluesProductionTeam"},"hoverEvent":{"action":"show_text","value":[{"text":"YouTube: ","color":"dark_aqua"},{"text":"CMDred","color":"white"}]}},"\n﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},"Get the latest updates: ",{"text":"Modrinth","color":"#5491F7","clickEvent":{"action":"open_url","value":"https://modrinth.com/datapack/macroengine_string"},"hoverEvent":{"action":"show_text","value":["Open page"]}},", ",{"text":"GitHub","color":"#5491F7","clickEvent":{"action":"open_url","value":"https://github.com/runtoolkit/macroEngine"},"hoverEvent":{"action":"show_text","value":["Open page"]}}]
