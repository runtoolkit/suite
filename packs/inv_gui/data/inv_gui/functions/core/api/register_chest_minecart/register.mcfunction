#> inv_gui:core/api/register_chest_minecart/register
# @within function inv_gui:core/api/register_chest_minecart/_

#>
# @private
#declare score_holder $TempIndex

# Register executor
tag @s add inv_gui.Entity

# Assign Index (1..32767)
scoreboard players add $MinecartIndex inv_gui 1
execute if score $MinecartIndex inv_gui matches 32768 run scoreboard players set $MinecartIndex inv_gui 1

# Assign Id
scoreboard players operation @s inv_gui.Id = $MinecartIndex inv_gui

# Set each bit of Index as Filter.N-{0|1} tag (macro loop: bit 15→0)
scoreboard players operation $TempIndex inv_gui = $MinecartIndex inv_gui
scoreboard players operation $TempIndex inv_gui *= $65536 inv_gui
scoreboard players set $_rbit inv_gui 15
function inv_gui:core/api/register_chest_minecart/encode_loop

# Reset
scoreboard players reset $TempIndex inv_gui
scoreboard players reset $_rbit inv_gui
