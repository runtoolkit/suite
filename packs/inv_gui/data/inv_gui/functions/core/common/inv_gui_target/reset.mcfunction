#> inv_gui:core/common/inv_gui_target/reset
#
# Remove inv_gui.Target tag
#
# @within function inv_gui:core/**

# Remove tag
tag @e[type=minecraft:chest_minecart, tag=inv_gui.Target] remove inv_gui.Target
