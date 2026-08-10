#> inv_gui:api/title
#
# Shows a title and optional subtitle to the executing player.
# Similar to inv_gui:api/actionbar but uses the title/subtitle display.
#
# @input
#   storage inv_gui:data in
#       title: string
#           Title text (must not contain double-quote characters)
#       subtitle?: string
#           Subtitle text (Default: "") (must not contain double-quote characters)
#       fade_in?: int
#           Fade-in duration in ticks (Default: 10)
#       stay?: int
#           Stay duration in ticks (Default: 70)
#       fade_out?: int
#           Fade-out duration in ticks (Default: 20)
#
# @api

function inv_gui:core/api/title/_
