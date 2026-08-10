#> inv_gui:core/api/build/ender_chest/_
#
# @input
#   storage inv_gui:data in
#       id: any
#       contents: (string[] @ 9)[] @ 3
#
# @within function inv_gui:api/build/ender_chest

## pre
function inv_gui:core/common/api/build/pre


# Create menu
function inv_gui:core/common/api/build/create_menu/_


## post
function inv_gui:core/common/api/build/post


# Set menu info in OhMyDat
function #oh_my_dat:please
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.MenuId set from storage inv_gui:data in.id
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.Contents set from block 10000 2 10000 Items

# Set menu
function inv_gui:core/api/build/ender_chest/set_menu


# Close session
function inv_gui:core/common/api/build/close_session

# Reset
data remove storage inv_gui:data in
