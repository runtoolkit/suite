#> inv_gui:api/sound
#
# Plays a sound to the executing player. Useful for UI feedback in menus.
#
# @input
#   storage inv_gui:data in
#       sound: string
#           Sound resource location (e.g. "minecraft:ui.button.click")
#       source?: string
#           Sound source category (Default: "master")
#       volume?: float
#           Volume multiplier (Default: 1.0)
#       pitch?: float
#           Pitch multiplier (Default: 1.0)
#
# @api

function inv_gui:core/api/sound/_
