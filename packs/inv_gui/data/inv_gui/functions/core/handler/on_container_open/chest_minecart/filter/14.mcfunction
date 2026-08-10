#> inv_gui:core/handler/on_container_open/chest_minecart/filter/14
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/15

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={14-0=true}}] if entity @s[tag=inv_gui.Filter.14-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/13
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={14-1=true}}] if entity @s[tag=inv_gui.Filter.14-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/13
