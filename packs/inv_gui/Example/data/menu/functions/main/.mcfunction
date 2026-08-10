#> menu:main/
#
# Create a menu
#
# @public

# button (gray_stained_glass_pane)
item replace block 10000 0 10000 container.0 with minecraft:gray_stained_glass_pane{display:{Name:'""'}}
data modify storage inv_gui:data in.key set value "f"
data modify storage inv_gui:data in.listener set value "Frame"
function inv_gui:api/register_item/button

# button (oak_door)
item replace block 10000 0 10000 container.0 with minecraft:oak_door{display:{Name:'"Teleport"'}}
data modify storage inv_gui:data in.key set value "D"
data modify storage inv_gui:data in.listener set value "DimensionsMenu"
function inv_gui:api/register_item/button


# Set menu contents
data modify storage inv_gui:data in.contents append value [f, f, f, f, f, f, f, f, f]
data modify storage inv_gui:data in.contents append value [f, -, -, -, D, -, -, -, f]
data modify storage inv_gui:data in.contents append value [f, f, f, f, f, f, f, f, f]

# Create a menu
data modify storage inv_gui:data in.id set value "main"
function inv_gui:api/build/auto
