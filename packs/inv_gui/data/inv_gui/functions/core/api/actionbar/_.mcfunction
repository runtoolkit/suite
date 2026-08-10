#> inv_gui:core/api/actionbar/_
#
# @within function inv_gui:api/actionbar

# Set defaults
execute unless data storage inv_gui:data in.color run data modify storage inv_gui:data in.color set value "white"

# Show via macro
data modify storage inv_gui:temp Actionbar set from storage inv_gui:data in
function inv_gui:core/api/actionbar/show with storage inv_gui:temp Actionbar

# Reset
data remove storage inv_gui:temp Actionbar
data remove storage inv_gui:data in
