#> inv_gui:core/handler/on_select/menu_type/ender_chest/_
# @within function inv_gui:core/handler/on_select/_

# Get menu info
function #oh_my_dat:please
data modify storage inv_gui:temp MenuId set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.MenuId
data modify storage inv_gui:temp Contents set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.Contents
data modify storage inv_gui:temp CurrentContents set from entity @s EnderItems

# Get item in changed slot
function inv_gui:core/handler/on_select/get_changed_slot

# Get normal item
data remove storage inv_gui:temp CurrentContents[{tag:{inv_gui:{isButton:true}}}]

# Callback
function inv_gui:core/handler/on_select/menu_type/ender_chest/callback

# Reset
data remove storage inv_gui:temp MenuId
data remove storage inv_gui:temp Contents
data remove storage inv_gui:temp CurrentContents
data remove storage inv_gui:temp Item
