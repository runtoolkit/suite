# Check if it's installed
scoreboard objectives add StringLib.Uninstall dummy
execute if score #StringLib.Init StringLib matches 1 run scoreboard players set #StringLib.Init StringLib.Uninstall 1
execute unless score #StringLib.Init StringLib.Uninstall matches 1 run tellraw @a ["﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},{"text":"⚠ Could not remove StringLib.\nIs it installed?","color":"red"}]
execute unless score #StringLib.Init StringLib.Uninstall matches 1 run return run scoreboard objectives remove StringLib.Uninstall
scoreboard objectives remove StringLib.Uninstall

# Tellraw
tellraw @s ["﹌ ",{"text":"StringLib >> ","color":"#99EAD6"},"Uninstalled StringLib (v0.2.0)"]

# Remove scoreboards & data storages
scoreboard objectives remove StringLib

scoreboard players reset #StringLib.Init
scoreboard players reset #StringLib.ShowLoadMessage
scoreboard players reset #StringLib.c-1
scoreboard players reset #StringLib.c100
scoreboard players reset #StringLib.StringsTotal
scoreboard players reset #StringLib.CharsLeft
scoreboard players reset #StringLib.CharsTotal
scoreboard players reset #StringLib.ConcatsLeft
scoreboard players reset #StringLib.SuccessCheck
scoreboard players reset #StringLib.FindLength
scoreboard players reset #StringLib.FindAmount
scoreboard players reset #StringLib.KeepEmpty
scoreboard players reset #StringLib.SeparatorLength
scoreboard players reset #StringLib.Max
scoreboard players reset #StringLib.SplitsLeft
scoreboard players reset #StringLib.Index
scoreboard players reset #StringLib.FoundNothing
scoreboard players reset #StringLib.ReturnValue
scoreboard players reset #StringLib.CheckString.CharsLeft
scoreboard players reset #StringLib.CheckString.IsFindLength

data remove storage macroengine:core/internal/string/zprivate data
data remove storage macroengine:core/internal/string/input concat
data remove storage macroengine:core/internal/string/input find
data remove storage macroengine:core/internal/string/input replace
data remove storage macroengine:core/internal/string/input insert
data remove storage macroengine:core/internal/string/input split
data remove storage macroengine:core/internal/string/output concat
data remove storage macroengine:core/internal/string/output to_lowercase
data remove storage macroengine:core/internal/string/output to_uppercase
data remove storage macroengine:core/internal/string/output to_number
data remove storage macroengine:core/internal/string/output to_string
data remove storage macroengine:core/internal/string/output find
data remove storage macroengine:core/internal/string/output replace
data remove storage macroengine:core/internal/string/output insert
data remove storage macroengine:core/internal/string/output split