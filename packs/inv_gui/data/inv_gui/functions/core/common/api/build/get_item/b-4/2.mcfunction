#> inv_gui:core/common/api/build/get_item/b-4/2
# @within function inv_gui:core/common/api/build/get_item/b-3/1

execute if score $TargetSlot inv_gui matches 4 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.4
execute if score $TargetSlot inv_gui matches 5 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.5
