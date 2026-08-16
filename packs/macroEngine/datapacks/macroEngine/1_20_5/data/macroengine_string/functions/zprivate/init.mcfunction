
# Load message (safe legacy for 1.20.x)
execute if score #StringLib.ShowLoadMessage StringLib matches 0 run return 0
execute if score #StringLib.ShowLoadMessage StringLib matches 1 run tellraw @a ["﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},"Installed StringLib (v0.2.0)"]
execute if score #StringLib.ShowLoadMessage StringLib matches 1 run tellraw @a ["﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},"Click /function macroengine_string:debug/toggle_load_message to toggle"]
