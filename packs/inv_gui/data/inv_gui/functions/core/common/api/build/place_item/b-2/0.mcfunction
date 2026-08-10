#> inv_gui:core/common/api/build/place_item/b-2/0
# @within function inv_gui:core/common/api/build/place_item/b-1/0

execute if score $TargetSlot inv_gui matches 0..3 run function inv_gui:core/common/api/build/place_item/b-3/0
execute if score $TargetSlot inv_gui matches 4..6 run function inv_gui:core/common/api/build/place_item/b-3/1
