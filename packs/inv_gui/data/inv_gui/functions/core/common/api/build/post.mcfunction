#> inv_gui:core/common/api/build/post
#
# Called after the Build API is executed
#
# @within function inv_gui:core/api/build/*/_

# Inside callback -> Set callback
execute if data storage inv_gui:core {isInCallback:true} run data modify storage inv_gui:data callback set from storage inv_gui:temp/build callback
execute if data storage inv_gui:core {isInCallback:true} run data remove storage inv_gui:temp/build callback
