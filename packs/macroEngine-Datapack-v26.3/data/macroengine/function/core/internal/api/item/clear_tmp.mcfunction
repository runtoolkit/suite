# macroengine:core/internal/api/item/clear_tmp
# Internal — do not call directly.
#
# Scheduled 3 ticks after any api/item/* call writes to the shared
# macroengine:_item_tmp scratch storage, so it doesn't sit populated
# between calls. 'replace' means repeated api/item/* calls within the
# same 3-tick window collapse onto a single pending clear instead of
# stacking redundant schedules — safe because every api/item/* function
# already overwrites (set value), never appends to, this storage, so an
# unclaimed stale key here can only ever be leftover scratch data, not
# something a later read depends on.
#
# NOTE: "data remove storage <id>" with no path is not valid — /data
# remove can only delete a key under a storage, never the storage root
# itself (see https://minecraft.wiki/w/Commands/data). Every top-level
# key ever written to _item_tmp across api/item/* must be listed here
# explicitly: player, macroengine, slot, expiry.
data remove storage macroengine:_item_tmp player
data remove storage macroengine:_item_tmp macroengine
data remove storage macroengine:_item_tmp slot
data remove storage macroengine:_item_tmp expiry
