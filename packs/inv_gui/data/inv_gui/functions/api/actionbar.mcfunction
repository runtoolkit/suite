#> inv_gui:api/actionbar
#
# Shows an actionbar message to the executing player.
# Useful for immediate feedback when a button is clicked.
#
# @input
#   storage inv_gui:data in
#       text: string
#           Message text (must not contain double-quote characters)
#       color?: string
#           Text color name (Default: "white")
#           e.g. "red", "green", "yellow", "gold", "aqua", "gray"
#
# @api

function inv_gui:core/api/actionbar/_
