#> inv_gui:core/api/build/chest_minecart/_
#
# @input
#   storage inv_gui:data in
#       id: any
#       contents: (string[] @ 9)[] @ 3
#
# @within function inv_gui:api/build/chest_minecart

## pre
function inv_gui:core/common/api/build/pre


# Register executor
function inv_gui:api/register_chest_minecart

# Create menu
function inv_gui:core/common/api/build/create_menu/_


## post
function inv_gui:core/common/api/build/post


# Set menu info in OhMyDat
function #oh_my_dat:please
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.MenuId set from storage inv_gui:data in.id
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.Contents set from block 10000 2 10000 Items

# Set menu
function inv_gui:core/api/build/chest_minecart/set_menu


# Close session
function inv_gui:core/common/api/build/close_session

# Reset
data remove storage inv_gui:data in
