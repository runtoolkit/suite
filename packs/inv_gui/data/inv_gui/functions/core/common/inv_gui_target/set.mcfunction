#> inv_gui:core/common/inv_gui_target/set
#
# Set inv_gui.Target tag on the chest minecart opened by the executor's player
#
# @within function inv_gui:core/**

#>
# @private
#declare tag inv_gui.this

# Identify the opened chest minecart
tag @s add inv_gui.this
execute as @e[type=minecraft:chest_minecart, tag=inv_gui.Entity] if score @s inv_gui.Id = @a[tag=inv_gui.this, limit=1] inv_gui.Id run tag @s add inv_gui.Target
tag @s remove inv_gui.this
