#> inv_gui:core/handler/on_container_open/chest_minecart/filter/8
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/9

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={8-0=true}}] if entity @s[tag=inv_gui.Filter.8-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/7
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={8-1=true}}] if entity @s[tag=inv_gui.Filter.8-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/7
