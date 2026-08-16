# macroengine:api/cb/queue_size
# ─────────────────────────────────────────────────────────────────
# Returns the number of pending delayed CB commands.
# Result is stored in score #cb_queue_size macroengine.tmp.
#
# EXAMPLE:
# function macroengine:api/cb/queue_size
# # read: scoreboard players get #cb_queue_size macroengine.tmp
# ─────────────────────────────────────────────────────────────────

execute store result score #cb_queue_size macroengine.tmp run data get storage macroengine:engine cb_queue
