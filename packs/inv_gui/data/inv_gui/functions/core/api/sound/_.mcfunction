#> inv_gui:core/api/sound/_
#
# @within function inv_gui:api/sound

# Build sound params: defaults first, then merge user input (overrides defaults)
data modify storage inv_gui:temp Sound set value {source:"master",volume:1.0,pitch:1.0}
data modify storage inv_gui:temp Sound merge from storage inv_gui:data in

# Play via macro
function inv_gui:core/api/sound/play with storage inv_gui:temp Sound

# Reset
data remove storage inv_gui:temp Sound
data remove storage inv_gui:data in
