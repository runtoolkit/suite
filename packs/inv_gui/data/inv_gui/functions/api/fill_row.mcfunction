#> inv_gui:api/fill_row
#
# Appends a full 9-slot row to in.contents, filled with the given key.
# Call before inv_gui:api/build/auto (or chest_minecart / ender_chest).
# Use "-" as the key to produce an empty slot row.
#
# @input
#   storage inv_gui:data in
#       key: string
#           Item key to fill the row with
#
# @api

function inv_gui:core/api/fill_row/_
