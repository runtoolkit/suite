#> inv_gui:core/api/title/_
#
# @within function inv_gui:api/title

# Set defaults
execute unless data storage inv_gui:data in.subtitle run data modify storage inv_gui:data in.subtitle set value ""
execute unless data storage inv_gui:data in.fade_in run data modify storage inv_gui:data in.fade_in set value 10
execute unless data storage inv_gui:data in.stay run data modify storage inv_gui:data in.stay set value 70
execute unless data storage inv_gui:data in.fade_out run data modify storage inv_gui:data in.fade_out set value 20

# Show via macro
data modify storage inv_gui:temp Title set from storage inv_gui:data in
function inv_gui:core/api/title/show with storage inv_gui:temp Title

# Reset
data remove storage inv_gui:temp Title
data remove storage inv_gui:data in
