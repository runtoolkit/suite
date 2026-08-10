#> inv_gui:core/handler/on_container_open/chest_minecart/filter/10
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/11

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={10-0=true}}] if entity @s[tag=inv_gui.Filter.10-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/9
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={10-1=true}}] if entity @s[tag=inv_gui.Filter.10-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/9
