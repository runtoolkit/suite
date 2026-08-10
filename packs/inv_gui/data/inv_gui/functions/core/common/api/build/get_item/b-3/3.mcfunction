#> inv_gui:core/common/api/build/get_item/b-3/3
# @within function inv_gui:core/common/api/build/get_item/b-2/1

execute if score $TargetSlot inv_gui matches 11..12 run function inv_gui:core/common/api/build/get_item/b-4/5
execute if score $TargetSlot inv_gui matches 13 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.13
