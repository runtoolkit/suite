# Init
scoreboard objectives add StringLib dummy
execute unless score #StringLib.Init StringLib matches 1 run function macroengine:core/internal/string/zprivate/init

# Tellraw
execute if score #StringLib.ShowLoadMessage StringLib matches 1 run tellraw @a ["﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},{"text":"Made by CMDred","hoverEvent":{"action":"show_text","contents":[{"text":"YouTube: ","color":"dark_aqua"},{"text":"CMDred","color":"white"}]}},"\n﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},"Get the latest updates: ",{"text":"Modrinth","color":"#5491F7","hoverEvent":{"action":"show_text","contents":["Open page"]}},", ",{"text":"GitHub","color":"#5491F7","hoverEvent":{"action":"show_text","contents":["Open page"]}}]
