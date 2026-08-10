#> inv_gui:core/common/api/build/get_item/b-4/0
# @within function inv_gui:core/common/api/build/get_item/b-3/0

execute if score $TargetSlot inv_gui matches 0 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.0
execute if score $TargetSlot inv_gui matches 1 run item replace block 10000 0 10000 container.0 from block ~ ~ ~ container.1
