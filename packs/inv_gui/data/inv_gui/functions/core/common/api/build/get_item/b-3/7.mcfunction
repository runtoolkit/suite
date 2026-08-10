#> inv_gui:core/common/api/build/get_item/b-3/7
# @within function inv_gui:core/common/api/build/get_item/b-2/3

execute if score $TargetSlot inv_gui matches 24..25 run function inv_gui:core/common/api/build/get_item/b-4/10
execute if score $TargetSlot inv_gui matches 26 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.26
