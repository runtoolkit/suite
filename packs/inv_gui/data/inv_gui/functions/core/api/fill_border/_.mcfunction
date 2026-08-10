#> inv_gui:core/api/fill_border/_
#
# @within function inv_gui:api/fill_border

data modify storage inv_gui:temp FillBorder.key set from storage inv_gui:data in.key
data remove storage inv_gui:data in.key

# Row 0: full row
function inv_gui:core/api/fill_border/full_row with storage inv_gui:temp FillBorder

# Row 1: only left and right columns
function inv_gui:core/api/fill_border/side_row with storage inv_gui:temp FillBorder

# Row 2: full row
function inv_gui:core/api/fill_border/full_row with storage inv_gui:temp FillBorder

data remove storage inv_gui:temp FillBorder
