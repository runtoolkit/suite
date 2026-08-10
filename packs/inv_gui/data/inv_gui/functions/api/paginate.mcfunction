#> inv_gui:api/paginate
#
# Slices a list of item keys to the current page window.
# Uses inv_gui:util/array/slice internally.
#
# @input
#   storage inv_gui:data in
#       items: string[]
#           Full list of item keys
#       page: int
#           Current page (0-indexed)
#       size?: int
#           Items per page (Default: 7)
#
# @output
#   storage inv_gui:data out
#       items: string[]
#           Item keys for the current page
#       has_prev: boolean (0b / 1b)
#           Whether a previous page exists
#       has_next: boolean (0b / 1b)
#           Whether a next page exists
#
# @api

function inv_gui:core/api/paginate/_
