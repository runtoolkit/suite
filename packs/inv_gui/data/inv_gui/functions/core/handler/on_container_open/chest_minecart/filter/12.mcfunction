#> inv_gui:core/handler/on_container_open/chest_minecart/filter/12
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/13

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={12-0=true}}] if entity @s[tag=inv_gui.Filter.12-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/11
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={12-1=true}}] if entity @s[tag=inv_gui.Filter.12-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/11
