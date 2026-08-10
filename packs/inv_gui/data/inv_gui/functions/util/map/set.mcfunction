#> inv_gui:util/map/set
#
# Adds, updates, or creates an element with the specified key and value
#
# @input
#   storage inv_gui:util in
#       key: any
#           Key of the element to set
#       value: any
#           Value of the element to set
#       map?: Map
#           Target Map to add/update (optional)
#
# @output
#   storage inv_gui:util out
#       map: Map
#           Map containing the set element
#
# @within * inv_gui:**

function inv_gui:util/map/core/set/_
