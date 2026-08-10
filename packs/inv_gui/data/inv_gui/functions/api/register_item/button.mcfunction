#> inv_gui:api/register_item/button
#
# Register an item as a button
#
# @input
#   vector 10000 0 10000
#       container.0
#           Item to be registered
#   storage inv_gui:data in
#       key: string
#           Key of the item to be registered
#       listener?: any
#           Event listener for the item to be registered (Optional)
#       isGlobal?: boolean
#           Whether it can be referenced from all locations (Default value: false) (Optional)
#
# @api

function inv_gui:core/api/register_item/button/_
