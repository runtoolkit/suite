#> inv_gui:core/handler/on_container_open/chest_minecart/filter/found
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/0

## Set inv_gui.Target
tag @s add inv_gui.Target


# Copy own inv_gui.Id to the player who opened
scoreboard players operation @a[tag=inv_gui.this] inv_gui.Id = @s inv_gui.Id
