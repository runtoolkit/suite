#> inv_gui:core/api/fill_row/_
#
# @within function inv_gui:api/fill_row

data modify storage inv_gui:temp FillRow.key set from storage inv_gui:data in.key
data remove storage inv_gui:data in.key
function inv_gui:core/api/fill_row/execute with storage inv_gui:temp FillRow
data remove storage inv_gui:temp FillRow
