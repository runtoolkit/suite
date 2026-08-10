#> inv_gui:core/handler/on_container_open/chest_minecart/filter/11
# @within function inv_gui:core/handler/on_container_open/chest_minecart/filter/12

execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={11-0=true}}] if entity @s[tag=inv_gui.Filter.11-0] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/10
execute if entity @a[tag=inv_gui.this, advancements={inv_gui:on_container_open={11-1=true}}] if entity @s[tag=inv_gui.Filter.11-1] run function inv_gui:core/handler/on_container_open/chest_minecart/filter/10
