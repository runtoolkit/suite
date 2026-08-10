#> inv_gui:core/handler/on_container_open/chest_minecart/filter/0
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/1

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={0-0=true}}] if entity @s[tag=inv_gui.Filter.0-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/found
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={0-1=true}}] if entity @s[tag=inv_gui.Filter.0-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/found
