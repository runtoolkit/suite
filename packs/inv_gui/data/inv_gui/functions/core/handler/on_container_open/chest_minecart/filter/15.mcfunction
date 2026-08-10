#> inv_gui:core/handler/on_container_open/chest_minecart/filter/15
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/find

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={15-0=true}}] if entity @s[tag=inv_gui.Filter.15-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/14
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={15-1=true}}] if entity @s[tag=inv_gui.Filter.15-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/14
