#> inv_gui:core/common/api/build/pre
#
# Called before the Build API is executed
#
# @within function inv_gui:core/api/build/*/_

# Inside callback -> Backup callback
execute if data storage inv_gui:core {isInCallback:true} run data modify storage inv_gui:temp/build callback set from storage inv_gui:data callback
execute if data storage inv_gui:core {isInCallback:true} run data remove storage inv_gui:data callback

# onSelect is used -> Set as having used Build API
execute if data storage inv_gui:core {CalledOnSelect:true} run data modify storage inv_gui:core CalledBuildApi set value true
