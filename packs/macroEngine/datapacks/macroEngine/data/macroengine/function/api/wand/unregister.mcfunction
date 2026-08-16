# ─────────────────────────────────────────────────────────────────
# macroengine:api/wand/unregister
# Removes all wand binds belonging to a specific tag.
#
# INPUT (storage macroengine:input):
# tag → wand tag to remove
#
# EXAMPLE:
# data modify storage macroengine:input tag set value "fire_wand"
# function macroengine:api/wand/unregister
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/api/wand/unregister_exec with storage macroengine:input {}
