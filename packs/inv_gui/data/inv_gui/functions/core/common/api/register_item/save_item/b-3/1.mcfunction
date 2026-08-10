#> inv_gui:core/common/api/register_item/save_item/b-3/1
# @within function inv_gui:core/common/api/register_item/save_item/b-2/0

execute if score $TargetSlot inv_gui matches 4..5 run function inv_gui:core/common/api/register_item/save_item/b-4/2
execute if score $TargetSlot inv_gui matches 6 run item replace block ~ ~ ~ container.6 from block 10000 0 10000 container.0
