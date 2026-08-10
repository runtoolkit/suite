#> menu:dimensions/
#
# Create a menu
#
# @public

# button (gray_stained_glass_pane)
item replace block 10000 0 10000 container.0 with minecraft:gray_stained_glass_pane{display:{Name:'""'}}
data modify storage inv_gui:data in.key set value "f"
data modify storage inv_gui:data in.listener set value "Frame"
function inv_gui:api/register_item/button

# button (barrier)
item replace block 10000 0 10000 container.0 with minecraft:barrier{display:{Name:'""'}}
data modify storage inv_gui:data in.key set value "B"
data modify storage inv_gui:data in.listener set value "Back"
function inv_gui:api/register_item/button

# variable
data modify storage inv_gui:data in.key set value "D"
function inv_gui:api/register_item/variable


# Set menu contents
data modify storage inv_gui:data in.contents append value [f, f, f, f, f, f, f, f, f]
data modify storage inv_gui:data in.contents append value [f, D, D, D, -, -, -, -, f]
data modify storage inv_gui:data in.contents append value [f, f, f, f, f, f, f, f, B]

# Create a menu
data modify storage inv_gui:data in.id set value "dimensions"
function inv_gui:api/build/auto
