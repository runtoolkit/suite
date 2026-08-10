#> inv_gui:core/common/api/set_menu/pre
#
# Called before the SetMenu API is executed
#
# @within function inv_gui:core/api/set_menu/_

# Inside callback -> Backup callback
execute if data storage inv_gui:core {isInCallback:true} run data modify storage inv_gui:temp/set_menu callback set from storage inv_gui:data callback
execute if data storage inv_gui:core {isInCallback:true} run data remove storage inv_gui:data callback
