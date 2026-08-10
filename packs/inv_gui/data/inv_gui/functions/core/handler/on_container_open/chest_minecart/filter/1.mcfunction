#> inv_gui:core/handler/on_container_open/chest_minecart/filter/1
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/2

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={1-0=true}}] if entity @s[tag=inv_gui.Filter.1-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/0
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={1-1=true}}] if entity @s[tag=inv_gui.Filter.1-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/0
