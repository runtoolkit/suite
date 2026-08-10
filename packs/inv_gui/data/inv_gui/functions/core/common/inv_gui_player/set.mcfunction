#> inv_gui:core/common/inv_gui_player/set
#
# Set inv_gui.Player tag on the player who opened the executor's chest minecart
#
# @within function inv_gui:core/**

#>
# @private
#declare tag inv_gui.this

# Identify the opened chest minecart
tag @s add inv_gui.this
execute as @a if score @s inv_gui.Id = @e[type=minecraft:chest_minecart, tag=inv_gui.this, limit=1] inv_gui.Id run tag @s add inv_gui.Player
tag @s remove inv_gui.this
