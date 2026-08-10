#> inv_gui:core/common/api/build/get_item/b-3/5
# @within function inv_gui:core/common/api/build/get_item/b-2/2

execute if score $TargetSlot inv_gui matches 18..19 run function inv_gui:core/common/api/build/get_item/b-4/8
execute if score $TargetSlot inv_gui matches 20 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.20
