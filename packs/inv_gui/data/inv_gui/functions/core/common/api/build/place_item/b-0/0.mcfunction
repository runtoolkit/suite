#> inv_gui:core/common/api/build/place_item/b-0/0
# @within * inv_gui:core/common/api/build/place_item/**

execute if score $TargetSlot inv_gui matches 0..13 run function inv_gui:core/common/api/build/place_item/b-1/0
execute if score $TargetSlot inv_gui matches 14..26 run function inv_gui:core/common/api/build/place_item/b-1/1
