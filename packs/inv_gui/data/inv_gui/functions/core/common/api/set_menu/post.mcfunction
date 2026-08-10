#> inv_gui:core/common/api/set_menu/post
#
# Called after the SetMenu API is executed
#
# @within function inv_gui:core/api/set_menu/_

# Inside callback -> Set callback
execute if data storage inv_gui:core {isInCallback:true} run data modify storage inv_gui:data callback set from storage inv_gui:temp/set_menu callback
execute if data storage inv_gui:core {isInCallback:true} run data remove storage inv_gui:temp/set_menu callback
