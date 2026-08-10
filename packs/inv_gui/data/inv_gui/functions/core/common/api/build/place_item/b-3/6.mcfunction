#> inv_gui:core/common/api/build/place_item/b-3/6
# @within function inv_gui:core/common/api/build/place_item/b-2/3

execute if score $TargetSlot inv_gui matches 21..22 run function inv_gui:core/common/api/build/place_item/b-4/9
execute if score $TargetSlot inv_gui matches 23 run item replace block ~ ~ ~ container.23 from block 10000 0 10000 container.0
