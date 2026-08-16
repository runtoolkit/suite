# ─────────────────────────────────────────────────────────────────
# macroengine:api/wand/give_lore
# Writes the wand with lore to mainhand (item replace).
#
# INPUT (storage macroengine:input):
# player → target player name
# tag → wand tag
# name → item name (string)
# lore → lore metni, TEK SATIR (string)
# color → lore color (e.g. "red", "gold", "gray")
#
# EXAMPLE:
# data modify storage macroengine:input player set value "Steve"
# data modify storage macroengine:input tag set value "fire_wand"
# data modify storage macroengine:input name set value "Fire Wand"
# data modify storage macroengine:input lore set value "Fire Damage: +20"
# data modify storage macroengine:input color set value "red"
# function macroengine:api/wand/give_lore
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/api/wand/give_lore_exec with storage macroengine:input {}
