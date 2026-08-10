#> inv_gui:core/load
#
# Called on load
#
# @within tag/function minecraft:load

# Version
execute unless data storage inv_gui:data Version run data modify storage inv_gui:data Version set value "1.0.0"

# Storage setup
execute unless data storage inv_gui:core GlobalItemInfoMap run data modify storage inv_gui:core GlobalItemInfoMap set value []
execute unless data storage inv_gui:util in run data remove storage inv_gui:util in

# Scoreboard setup
scoreboard objectives add inv_gui dummy
scoreboard objectives add inv_gui.Id dummy
scoreboard objectives add inv_gui.Drop custom:minecraft.drop

# Score holder setup
execute unless score $LocalItemSlotIndex inv_gui = $LocalItemSlotIndex inv_gui run scoreboard players set $LocalItemSlotIndex inv_gui 0
execute unless score $MinecartIndex inv_gui = $MinecartIndex inv_gui run scoreboard players set $MinecartIndex inv_gui 0

# Constant setup
scoreboard players set $65536 inv_gui 65536

# Notify all players that inv_gui has been loaded
tellraw @a ["",{"text":"[","color":"dark_aqua"},{"text":"inv_gui","color":"aqua","bold":true},{"text":"] ","color":"dark_aqua"},{"text":"v1.0.0 loaded.","color":"white"}]
