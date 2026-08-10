#> inv_gui:core/handler/on_container_open/chest_minecart/filter/6
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/7

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={6-0=true}}] if entity @s[tag=inv_gui.Filter.6-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/5
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={6-1=true}}] if entity @s[tag=inv_gui.Filter.6-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/5
