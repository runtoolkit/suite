#> inv_gui:core/common/api/register_item/save_item/b-4/0
# @within function inv_gui:core/common/api/register_item/save_item/b-3/0

execute if score $TargetSlot inv_gui matches 0 run item replace block ~ ~ ~ container.0 from block 10000 0 10000 container.0
execute if score $TargetSlot inv_gui matches 1 run item replace block ~ ~ ~ container.1 from block 10000 0 10000 container.0
